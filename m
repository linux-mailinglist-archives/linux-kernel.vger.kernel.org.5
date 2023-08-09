Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2E775F18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjHIMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjHIMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:32:10 -0400
Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3171BF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:32:08 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id TiM9qzlPdRGumTiM9qrAiE; Wed, 09 Aug 2023 14:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691584325; bh=oPP7E+kojgmjKyIpQ8sukDlf8aNPe96/5zs01WZNpeE=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=K07229leQiW2t1Mv7TrkQVHftqre1qhEKnPvUs/4BZ5/c4AkBwDO/ZFfTtrijwIpu
         UJZYNg9Y9j343AUmIyZu5bGwjxX4WzLX1781SClbeIoRPOOOrSaAvGgo1A8jiH5thc
         IAPqFG3BQExWtQnMR5assSe9URh+ovRW6UXReWMqsGNnhJCY0H33MgcFiI6nicWpDM
         a0dYG7Iqm4pOU6mLc/tegvS3axmlUfhBPijC3w+mkaekq1Cv3ScTGUzy4mSi9t9Lzu
         IyBIB/dBb/EfFkVRDUNbTqNunH6UUZKviHJHONi2nYhYMwwrrbNtLxSkIB5adUKUbw
         NGAwOGhosubcg==
Message-ID: <525f8fd4-1d1f-ef46-289e-632865d0684b@enneenne.com>
Date:   Wed, 9 Aug 2023 14:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: pps: pps-gpio: Convert to yaml
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230809110812.2058428-1-festevam@gmail.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20230809110812.2058428-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCjZ4teLqZjh2U/woo2fkhpxLNIo2foVM9Lz/b8Q0PkwOlmSnjR5PNecuYXJ07JflUfJgt2h2eXMpEcs93R/2Qj6dYgiHANRSMcT8CN2Ko4gFJwHzsrl
 r/JvQbvdnWIpvt8ovNgEiO/l2YAHMXizVHHDeRD6E2Wj3VTgK3TH8dpeeeiDVQWMUs0gqJ2Lui7ZX2gR7QA00HRBn37dqIBMmW7N8WWlcA57JdaITSq2e3/L
 FDynGhjekHAv4fnNr7od9kmiZGIqV5kr1bftRB0WSLfQS7LV7fOWQ8gShQ7dNOIMbBiqtedP4qm8xQp8SZuhrCND0a9AmFpp6TrjTCkwIQgZvZ9hcl2QE0H3
 hERpj8itu1PY+MVI4WtNyYFaKax+FJy2HwwKB+Fcpr3QYfYI8rs=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 13:08, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert from pps-gpio.txt to pps-gpio.yaml to allow schema validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   .../devicetree/bindings/pps/pps-gpio.txt      | 30 ------------
>   .../devicetree/bindings/pps/pps-gpio.yaml     | 46 +++++++++++++++++++
>   2 files changed, 46 insertions(+), 30 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.txt
>   create mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> deleted file mode 100644
> index 9012a2a02e14..000000000000
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Device-Tree Bindings for a PPS Signal on GPIO
> -
> -These properties describe a PPS (pulse-per-second) signal connected to
> -a GPIO pin.
> -
> -Required properties:
> -- compatible: should be "pps-gpio"
> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> -
> -Additional required properties for the PPS ECHO functionality:
> -- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
> -- echo-active-ms: duration in ms of the active portion of the echo pulse
> -
> -Optional properties:
> -- assert-falling-edge: when present, assert is indicated by a falling edge
> -                       (instead of by a rising edge)
> -
> -Example:
> -	pps {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_pps>;
> -
> -		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> -		assert-falling-edge;
> -
> -		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> -		echo-active-ms = <100>;
> -
> -		compatible = "pps-gpio";
> -	};
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.yaml b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> new file mode 100644
> index 000000000000..801fd2720080
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pps/pps-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PPS Signal via GPIO
> +
> +maintainers:
> +  - Fabio Estevam <festevam@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: pps-gpio
> +
> +  gpios:
> +    description: The GPIO that provides the PPS signal.
> +
> +  echo-gpios:
> +    description: The GPIO that provides the PPS ECHO signal.
> +
> +  echo-active-ms:
> +    description: Duration in ms of the active portion of the echo pulse.
> +
> +  assert-falling-edge:
> +    description: Indicates a falling edge assert, when present. Rising edge if absent.
> +
> +required:
> +  - compatible
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +
> +      pps {
> +          compatible = "pps-gpio";
> +          pinctrl-names = "default";
> +          pinctrl-0 = <&pinctrl_pps>;
> +          gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +          assert-falling-edge;
> +          echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +          echo-active-ms = <100>;
> +      };

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

