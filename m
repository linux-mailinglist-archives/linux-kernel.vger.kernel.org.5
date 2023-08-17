Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022777F230
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbjHQI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348955AbjHQI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F60103;
        Thu, 17 Aug 2023 01:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2C5626E1;
        Thu, 17 Aug 2023 08:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836AC433CC;
        Thu, 17 Aug 2023 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692260946;
        bh=DYJ39J2Cr/II33zDyAHO799O45vh28LS4kBqvN4ljSc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MODxE91OAzSWovesnvUYri05hf98/4dsiM83dBUq8CeBhh1URaADHGxvl4n43WTi4
         O2cd1HeBtxp7CvnKIfrH4fBqjQ/DM0bl16qrZ2NjZXlZvCyKrW/1Vr7jSx3YoniPLD
         POxr2bZ8zvIrOUitgqHZCJ6EGV5VGqRNbT3LBrukVr6m982uBtksNa0IScixLroN8d
         92PMCfNQG8TBGF+FrWy/FY916NPA4PNYIasB4adI5u1gQf0kJb7sATDkTCTmSH0KLS
         ymFf4tB/p6wrqczxqeAW82m6f4w0zk991tKBtJV0rOp05IaJkIGvfHStm3wlHy1gmK
         TYLdgvBGIH23Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
In-Reply-To: <20230728153731.3742339-4-jjhiblot@traphandler.com>
References: <20230728153731.3742339-1-jjhiblot@traphandler.com>
 <20230728153731.3742339-4-jjhiblot@traphandler.com>
Subject: Re: (subset) [RESEND] [PATCH v11 3/4] dt-bindings: leds: Add
 binding for a multicolor group of LEDs
Message-Id: <169226094407.909741.16273565349246008268.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 09:29:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 17:37:30 +0200, Jean-Jacques Hiblot wrote:
> This allows to group multiple monochromatic LEDs into a multicolor
> LED, e.g. RGB LEDs.
> 
> 

Applied, thanks!

[3/4] dt-bindings: leds: Add binding for a multicolor group of LEDs
      commit: 099c52d9448c1ca832b4695e982221a521282b94

--
Lee Jones [李琼斯]

