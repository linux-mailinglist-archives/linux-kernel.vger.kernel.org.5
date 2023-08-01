Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640CD76B398
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHALoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjHALom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A292;
        Tue,  1 Aug 2023 04:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA596156E;
        Tue,  1 Aug 2023 11:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C58C433C8;
        Tue,  1 Aug 2023 11:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690890280;
        bh=dbodHSwIgKgpR708XhGtQfRJC68lUns//VtMieKP9nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIPN/0FlrywKoIvGuj184pORf/lD8hhwluBTGh+LkJQPCLledF7sFrBYwGV/lqUS1
         523bB6efo7rFR3KMuWoIJhQr4Bdcgm9DWfXIm7yGqW2lahDabJWA2iv5BlA4oi9H6I
         E1J608KbtQ3ZReXwf9vUfA6ouEDGz27xA4f6lSvhMoRmPdcW72n4i/q07LTV+DtI4k
         khUoBRy5gFFucKponYrQlQ2svb9z4sncsgjZNL59SYR06uNZWn9aiJbYOEgGForKMM
         ve6Ez9aeP1r+xBgk7F+Ee+2DMbgCNEv20Uz60Ak6AlyqGQ5nxLVj8l+HlfWckYM9BT
         haR5vtYw/l+kA==
Date:   Tue, 1 Aug 2023 13:44:37 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Keith Zhao <keith.zhao@starfivetech.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v1 v1 2/7] dt-bindings: display: Add yamls for JH7110
 display system
Message-ID: <hsuuag25psaxd6wgtaohpakxi3pppg6xk4w7x64ubwjir5pjb3@vrqns6ptrzzm>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
 <20230801101030.2040-3-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dan5yrpicomxdg2s"
Content-Disposition: inline
In-Reply-To: <20230801101030.2040-3-keith.zhao@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dan5yrpicomxdg2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 01, 2023 at 06:10:25PM +0800, Keith Zhao wrote:
> diff --git a/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
> new file mode 100644
> index 000000000..bebe2050c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/starfive/starfive,jh7110-dc8200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive display controller
> +
> +description:
> +  The StarFive SoC uses the display controller based on Verisilicon IP
> +  to transfer the image data from a video memory
> +  buffer to an external LCD interface.
> +
> +maintainers:
> +  - Keith Zhao <keith.zhao@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-dc8200
> +
> +  reg:
> +    maxItems: 3

What these registers are used for must be documented.

> +
> +  interrupts:
> +    items:
> +      - description: The interrupt will be generated when DC finish one frame
> +
> +  clocks:
> +    items:
> +      - description: Clock for display system noc bus.
> +      - description: Pixel clock for display channel 0.
> +      - description: Pixel clock for display channel 1.
> +      - description: Clock for axi interface of display controller.
> +      - description: Core clock for display controller.
> +      - description: Clock for ahb interface of display controller.
> +      - description: External HDMI pixel clock.
> +      - description: Parent clock for pixel clock
> +
> +  clock-names:
> +    items:
> +      - const: vout_noc_disp
> +      - const: vout_pix0
> +      - const: vout_pix1
> +      - const: vout_axi
> +      - const: vout_core
> +      - const: vout_vout_ahb
> +      - const: hdmitx0_pixel
> +      - const: vout_dc8200

The clock-names should reflect what they are used for on the device, not
what their name is in the system. So it should rather be something like
"noc-bus", "channel0", "channel1", etc.

vout, or the soc model, shouldn't appear there.

> +  resets:
> +    items:
> +      - description: Reset for axi interface of display controller.
> +      - description: Reset for ahb interface of display controller.
> +      - description: Core reset of display controller.
> +
> +  reset-names:
> +    items:
> +      - const: vout_axi
> +      - const: vout_ahb
> +      - const: vout_core

Ditto.

Also, I'm a bit confused, how can a device be attached to both an AXI
and AHB bus? That, plus the multiple registers spaces, make me think
that this is multiple devices glued together in a single node, which
isn't ok.

> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dc8200: lcd-controller@29400000 {
> +        compatible = "starfive,jh7110-dc8200";
> +        reg = <0x29400000 0x100>, <0x29400800 0x2000>, <0x295b0000 0x90>;
> +        interrupts = <95>;
> +        clocks = <&syscrg 60>,
> +               <&voutcrg 7>,
> +               <&voutcrg 8>,
> +               <&voutcrg 4>,
> +               <&voutcrg 5>,
> +               <&voutcrg 6>,
> +               <&hdmitx0_pixelclk>,
> +               <&voutcrg 1>;
> +        clock-names = "vout_noc_disp", "vout_pix0", "vout_pix1",
> +                      "vout_axi", "vout_core", "vout_vout_ahb",
> +                      "hdmitx0_pixel","vout_dc8200";
> +        resets = <&voutcrg 0>, <&voutcrg 1>, <&voutcrg 2>;
> +        reset-names = "vout_axi", "vout_ahb", "vout_core";
> +        dc_out: port {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            dc_out_hdmi: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&hdmi_in_dc>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
> new file mode 100644
> index 000000000..f6927acf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/starfive/starfive,jh7110-inno-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive JH7110 HDMI controller
> +
> +description:
> +  The StarFive JH7110 SoC uses the HDMI signal transmiter based on innosilicon IP
> +  to generate HDMI signal from its input and transmit the signal to the screen.
> +
> +maintainers:
> +  - Keith Zhao <keith.zhao@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: "starfive,jh7110-inno-hdmi"
> +
> +  reg:
> +    minItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: The HDMI hot plug detection interrupt.
> +
> +  clocks:
> +    items:
> +      - description: System clock of HDMI module.
> +      - description: Mclk clock of HDMI audio.
> +      - description: Bclk clock of HDMI audio.
> +      - description: Pixel clock generated by HDMI module.
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: mclk
> +      - const: bclk
> +      - const: pclk
> +
> +  resets:
> +    items:
> +      - description: Reset for HDMI module.
> +
> +  reset-names:
> +    items:
> +      - const: hdmi_tx

If there's only one you don't need reset-names

Maxime

--dan5yrpicomxdg2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMjwJQAKCRDj7w1vZxhR
xZBQAPwPOEedmxWZJ27iqcESJscaRD6CHACzB6No3CR39QnaDgD/bbKScqVg2wHb
dTG9DGpqq1ezLI5zfPLEM3steJgVlg4=
=A6ek
-----END PGP SIGNATURE-----

--dan5yrpicomxdg2s--
