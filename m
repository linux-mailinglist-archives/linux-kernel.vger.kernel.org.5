Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D558077F3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349765AbjHQJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349789AbjHQJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700C271F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB4666171
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE0BC433C7;
        Thu, 17 Aug 2023 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692265213;
        bh=xpbdzGLUOvexU3mTAljv0idjDmeYCefF/CKSn1i8sd0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RhfkeihODD27NrMIpunQr1ENDC/yjwdm8E3FvxPVEG1sq/fEKhR7kawW5KqMY3awN
         +fu2ikUT/6U/AI03rjzgZvQj3CW+UVHPAEsEvozD1L8GRm+bBBdz3DWXZaB8zkIY4Z
         Y6nyZNmFSA/+meQ5RfUjoz7djzdvM2EbZGf7lIa5ZD5U56foOqyEiSYHLmW2J0auZd
         ksVS/Gkzl3PMKqxglxChX6+cYP8dtDjvZvk5asdATW+i37Up5ZwgVaLEgAWdhAkI1s
         YM37/labkSJA/TuZli4tqOCuQ8rjzW9jBlDl7aZjzbb/zvFe92ZzCihn/GGuK/IVug
         KG0CLoUIeHVpA==
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
In-Reply-To: <20230801085158.87735-1-alexander.stein@ew.tq-group.com>
References: <20230801085158.87735-1-alexander.stein@ew.tq-group.com>
Subject: Re: (subset) [RESEND v2 1/1] MAINTAINERS: Add entry for TQ-Systems
 device trees and drivers
Message-Id: <169226521124.948515.8729043249449090860.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 10:40:11 +0100
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

On Tue, 01 Aug 2023 10:51:58 +0200, Alexander Stein wrote:
> This includes the arm & arm64 module + board DT files as well as x86
> platform GPIO drivers.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add entry for TQ-Systems device trees and drivers
      commit: 50d90d9c613a3788ba99ec2e7fabd6bb91e3f7dd

--
Lee Jones [李琼斯]

