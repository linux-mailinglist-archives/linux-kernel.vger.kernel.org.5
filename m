Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797377F452
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349700AbjHQK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbjHQK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D62D54;
        Thu, 17 Aug 2023 03:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719C663D63;
        Thu, 17 Aug 2023 10:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71DDC433C7;
        Thu, 17 Aug 2023 10:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692268162;
        bh=kZwwMK65BocKYlXt+xCfcxEkAY2vY1NEmm4JyhjbwcI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=inau0KofU33iBmtvkrVF88taotlkiuDMJwd4XBg3FUeYVkkLyvtzzOl9aTBpjEc4r
         f9NkCOgRcwiB4QF5jsrmaxsGkt3LvNBAGM4Mx6JFWPPCBX3zReJ6IN1ESrUR5HEqdF
         CHygqvt3+LCiJC5837DBLr7IRQogvwnTiSHWo3QyVMYht4Frl/QuthFZZCalYniiDR
         rHvTrM9r7i9JdcdDX91HUpyove7ij0VgXPG5CqNpKLX4CdmQA7EYTbrpSMYUFf6yXW
         d04lB9KuBQ+dHhDGoKT/sG3v4cLhLJCzv5aS3AnQC1PjmowYAywIcyat81eF0JHUiQ
         IaRVoGIQStHLA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728171123.110489-1-krzysztof.kozlowski@linaro.org>
References: <20230728171123.110489-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: leds: rohm,bd71828: Drop
 select:false
Message-Id: <169226816059.966886.7816769511198769175.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 11:29:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 19:11:23 +0200, Krzysztof Kozlowski wrote:
> select:false makes the schema basically ignored (not selected for given
> compatible), unless some other binding references it.  It's not really
> useful nor needed for device bindings, even if they are part of other
> binding (like MFD).
> 
> 

Applied, thanks!

[1/1] dt-bindings: leds: rohm,bd71828: Drop select:false
      commit: f044ae6b5a215df5420705dbaa287c59d8d5ef6b

--
Lee Jones [李琼斯]

