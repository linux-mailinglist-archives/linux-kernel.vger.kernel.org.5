Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D84805C75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbjLEPR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346868AbjLEPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB2D5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:17:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC45C433CA;
        Tue,  5 Dec 2023 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789428;
        bh=RbLg9T6AMJ5NL/D819BJlKf7wAYf0xJaQbaEvx+laAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bw9LE1Wa/2C4T7BBITd2qcWq/ha/cEPhgIFiN2NgwWfkuMTfjK/JocYA4i/nrrz8E
         vd9Zs0+X92gZRNGIT9HeziLtrtxBGbjKDfqS3rCUMuUL6XeWfVNQBw1RV8GcfbkVPs
         +OhPlc+Rsn5xYw2wSK3w4c72rwCGuipPf2wSe1CsgaDbowPjF1LhhMP2ySkfynCupB
         j4mJob5avu+hNYBD0ojoPvqIlA9mC146m0LlOs2QVbmK2yipP3KrTTVKpuMNFxgLOS
         yyJhhnLDuGIw2XlU2U5St8A+N2Wrg3ZD84SqzUN2Wxq9/PzHRdX9veD3GgnzZjW8jO
         9dfsFSV/eCH+Q==
From:   Will Deacon <will@kernel.org>
To:     Tsung-Han Lin <tsunghan.tw@gmail.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Dcoumentation/arch/arm64: fix typo
Date:   Tue,  5 Dec 2023 15:16:37 +0000
Message-Id: <170178649190.14021.17307806382838211619.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231203011804.27694-1-tsunghan.tw@gmail.com>
References: <20231203011804.27694-1-tsunghan.tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2023 09:18:04 +0800, Tsung-Han Lin wrote:
> Should be 'if' here.
> 
> 

I, err, fixed the typo in the subject when applying this...

Applied to arm64 (for-next/misc), thanks!

[1/1] Dcoumentation/arch/arm64: fix typo
      https://git.kernel.org/arm64/c/365b1900c93a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
