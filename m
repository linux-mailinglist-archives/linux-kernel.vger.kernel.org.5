Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA987F621E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjKWOyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbjKWOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E1D60
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:54:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D66C433C8;
        Thu, 23 Nov 2023 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700751289;
        bh=WVecSFWfBVZt7eHFDKvJJUv63uzdwj5MUayfwitPJng=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UI1vN4bXnDluSjqdzluU7xIHm1q2q0PduZMPaBxZJNaJFOJ8QeiJY2xs9hZwjej8A
         +PbvFS5rsJlmivgH6c6kLlwfzU6HhVXxgudulfWfC2pJDrSa30qmQ831rZziWqvWTX
         0ZTeDoyQb73HrG4lHjq1NZh6KXTWZMBa2cm9AhRBC4zXO5gZahAWOjQPKE5H3gS61W
         4M+KsuvhlrywqvebBe9DXy3Z1A021BSGy9Gacewbag8698aktWkWy1RXzeOHVrcVDM
         dadaNEHK6UkxJZAFziVEce8EvU2ezt2howCEwqd9Y5gCbiOKkE+yo7VgBYK2nGyQ22
         sQUNpIgoP94DA==
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
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231116105319.957600-1-f.suligoi@asem.it>
References: <20231116105319.957600-1-f.suligoi@asem.it>
Subject: Re: [PATCH v7 0/2] backlight: mp3309c: Add support for MPS MP3309C
Message-Id: <170075128649.1369133.8551722036774346120.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 14:54:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 11:53:17 +0100, Flavio Suligoi wrote:
> This patchset (rebased on v6.7.0-rc1 kernel version):
> 
> - includes and updates the mps,mp3309c.yaml dt bindings file:
>     - Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>     Note: the patch related to this file was previously a separate patch
>           and sent in two versions (v1 and v2).
>           It has now been included in this patchset, starting with the
>           version v6.
> - adds the related device driver to support the MPS MP3309C backlight chip
> - adds missed history of previous versions
> - adds missed "Acked-by" and "Reviewed-by" added in previous versions
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: backlight: mp3309c: remove two required properties
      commit: 87f33a1b8f7e3d223fc331fe54fd8ec337dc9cb9
[2/2] backlight: mp3309c: Add support for MPS MP3309C
      commit: 2e914516a58cf86bd0e42c7d3e25c81d44ec2ab8

--
Lee Jones [李琼斯]

