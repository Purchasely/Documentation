# Android v6 Presentation API

The Android SDK v6 Presentation API is the canonical model for Android integrations.

## Naming rules

- Use **Presentation** for runtime SDK objects.
- Use **Screen** for Console-authored visual content and direct identifiers.
- Use `screenId` for direct Screen lookup.
- Do not introduce new public Android APIs named `presentationId`.

## Builder lifecycle

```kotlin
val prepared = PLYPresentation {
    placementId("onboarding")
    screenId("screen_abc123")
    contentId("article_42")
    flowId("flow_abc123")
    backgroundColor(0xFF101820.toInt())
    progressColor(0xFFFFC857.toInt())
    displayCloseButton(true)
    displayBackButton(true)
    onPresented { presentation, error -> }
    onCloseRequested { }
    onDismissed { outcome -> }
}
```

```kotlin
val loaded = prepared.preload()
loaded.display(activity) { outcome -> }
```

`display(activity) { outcome }` is the final dismissal callback.

## StateFlow

`PLYPresentationBuilder`, `PLYPresentationPrepared`, and loaded `PLYPresentation` expose `state: StateFlow<PLYPresentationState>`.

States:

- `Idle`
- `Loading`
- `Loaded`
- `Displayed`
- `Error(error)`

## Outcome

```kotlin
data class PLYPresentationOutcome(
    val presentation: PLYPresentation?,
    val purchaseResult: PLYPurchaseResult?,
    val plan: PLYPlan?,
    val closeReason: PLYCloseReason? = null,
    val error: PLYError? = null,
)
```

## Embedded Compose

Add the optional artifact:

```kotlin
implementation("io.purchasely:presentation-compose:6.0.0")
```

Use:

```kotlin
PLYPresentationView(
    presentation = presentation,
    modifier = Modifier.fillMaxWidth(),
    callback = { outcome -> }
)
```
