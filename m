Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225E785F34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjHWSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjHWSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288A1AD;
        Wed, 23 Aug 2023 11:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6532763A12;
        Wed, 23 Aug 2023 18:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEE4C433C8;
        Wed, 23 Aug 2023 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692813970;
        bh=fjXSLSy3WEZTv3uqwqTkRVnSzz6Rn81OEXWWbM6LqtI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mfHvotbp3o0f8VJBONDvCHYEm8vU/iwT12Fkgt6d69nj9IumERsQ1TZ4vxTcy5UcQ
         pF1WcDfv0ZHz/el5vPdmiUitFyzNlzRp8VElq7ftUVlYwqSA74RhKry+lldch9HSgh
         kIq9ZN2+I9DznTkwmPf1DnnVykoVICVFtbAiHyTQN1QO+svDTaqN8BWiUYq8B45HGi
         V1CYm4FicnSvRAedMnnn93O5Az63/zmRZ+a3Ra1XnXTaibEO6LaybF3ETpaaWn5ZjY
         9A7ElWRcQ5iyEUf8bUOivvgc9IGX9q6ckUPwlsACqLYEBPe8nC2vX2UoPOJY0XcVKC
         ZYp+jbqqUaFTw==
Message-ID: <8c918dc8f68feb92519e5b327b5c5c3c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
References: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: use capital "OR" for multiple licenses in SPDX
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Wed, 23 Aug 2023 11:06:08 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-08-23 01:45:40)
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>=20
> Correct also the format // -> .* in few Allwinner binding headers as
> pointed out by checkpatch:
>=20
>   WARNING: Improper SPDX comment style for 'include/dt-bindings/reset/sun=
50i-h6-ccu.h', please use '/*' instead
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
