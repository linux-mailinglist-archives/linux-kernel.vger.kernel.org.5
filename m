Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF17B3855
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjI2RG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjI2RGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:06:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A91A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:06:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8D1C433CB;
        Fri, 29 Sep 2023 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696007179;
        bh=9+DgkOhEoMkC8agmEyJjyTFg63Y1uL/tIHiEHDxWf7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uybg1Xd9ah9Ra284mBUDc4gzMPsAH3DlaY84G2BZvw/r2uD8ifiWS5uYqKDblrPrb
         dQMsHsC9YV506YRFaMcZf2AuHxkxPaKRL1QKNDSGC/MLJTPyJBPJ6XQ19wmXCTR2W8
         EpAT6cYO276+CnWolzXQElfNASfHny+1FmiLNBUhFGfN/Bf3m5Vb5xjAdxDkQVRAbp
         2yutNo7YlQ4A+PjvvhZ+4GkI+bSiddHk3/MRtxOwS3qN+a/rQvvYsiI5pT9Hnxnvcj
         pbwJoBR/JiY4Vd0LWkAWORcf4jsJ4G+JaF4nCetfwm493nFaxw2WavCzdXtR+YhD1T
         lvuozEGLGln4g==
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: Add Cortex-A520 CPU part definition
Date:   Fri, 29 Sep 2023 18:06:08 +0100
Message-Id: <169600149339.283416.17172127147851578552.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230921194156.1050055-1-robh@kernel.org>
References: <20230921194156.1050055-1-robh@kernel.org>
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

On Thu, 21 Sep 2023 14:41:51 -0500, Rob Herring wrote:
> Add the CPU Part number for the new Arm design.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: Add Cortex-A520 CPU part definition
      https://git.kernel.org/arm64/c/a654a69b9f9c
[2/2] arm64: errata: Add Cortex-A520 speculative unprivileged load workaround
      https://git.kernel.org/arm64/c/471470bc7052

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
