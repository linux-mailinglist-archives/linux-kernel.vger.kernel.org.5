Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110177CF8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbjJSM16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjJSM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:27:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B5136;
        Thu, 19 Oct 2023 05:27:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E85C433C8;
        Thu, 19 Oct 2023 12:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718473;
        bh=o+SLMHbM3b4KJWGJ8NBC4IKXQx11TH3ol/WMx76KbuQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OvzoOirf4oKfeLwF55oxfPT5FX6xkwQtXMIrat5FQNhVM212k4MBKanCDegSO/Qou
         wt3BitFJy6SfkKoL94TgboTUGjKcIHyuvCa7dCL/OA369MClGpyUpzjsO8qSkV6oFi
         kSDzXYMncbyrqmZJKHm4GTLLxp/555nPdF1j3JqIxhHf5AnUp8LBOVmYDkdxJ0Dq5i
         4ih2JTZNi13rutnOJ+dF/baOmRQLIq+xso3ng7kYWuh1KVrCzSAGxpD6RwoUcWwc8B
         +xyjAIhmWyniy/DDoUTXlWNovYtQSArMN2gFu1SgMo4XO3EyXzanhlLCjWj4FPQmVu
         vyu3594toMJFg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231016150554.27144-1-f.suligoi@asem.it>
References: <20231016150554.27144-1-f.suligoi@asem.it>
Subject: Re: (subset) [PATCH v1] dt-bindings: backlight: add
 brightness-levels related common properties
Message-Id: <169771847099.2473402.8532120354222006296.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 13:27:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 17:05:54 +0200, Flavio Suligoi wrote:
> Both files pwm-backlight.yaml and led-backlight.yaml contain properties
> in common with each other, regarding the brightness levels:
> 
> - brightness-levels
> - default-brightness-level
> 
> These properties can then be moved to backlight/common.yaml.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: backlight: add brightness-levels related common properties
      commit: d5272d39995f4150062a67e6f2cef556edece740

--
Lee Jones [李琼斯]

