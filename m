Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596D27A47D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbjIRLFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbjIRLFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6958F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:05:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23CAC433C9;
        Mon, 18 Sep 2023 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695035140;
        bh=nTQlrt3lgAXWEoIiVTnu+p7YvjL/2P0PI5wfelUMFBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdLFniGb+wsrAEKo6lm+VWEu0UwTCRq5XkYety8W3AUn+3mF/vcAUz+QAJ4QQcQKK
         NzCU52X7NzUJhFeSraLzj1lKUVpKl4e9RoM+Pk//M7VA9ct4SEpDflWTBV234PS1nC
         SAipN9fgfLsDFs4Al+X0xzjYD7xqZWg0i1A5clFZH68YQUPGatf/1gBlO9FPo8h06n
         YjZGc2D5W9kxWdN14xFYHWZ1SYDfbcBkSPnQUtWLFDJjBK6UaT8rO+oZoZWjsresis
         dECQZSvmA6/mfWkD1UpLDrAOa61RtYDIfP/jW1OXzllYP6yCssfJtF26H/00O7JCpy
         povGm16SA0f/w==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/sme: Include ID_AA64PFR1_EL1.SME in cpu-feature-registers.rst
Date:   Mon, 18 Sep 2023 12:05:16 +0100
Message-Id: <169503037342.1328390.858083161547236740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914-arm64-pfr1-sme-doc-v1-1-b6c497d10d77@kernel.org>
References: <20230914-arm64-pfr1-sme-doc-v1-1-b6c497d10d77@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 11:11:31 +0100, Mark Brown wrote:
> We expose ID_AA64PFR1_EL1.SME to userspace but do not document this in
> cpu-feature-registers.rst. Add it.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/sme: Include ID_AA64PFR1_EL1.SME in cpu-feature-registers.rst
      https://git.kernel.org/arm64/c/046b212ac930

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
