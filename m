Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9642A788798
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbjHYMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244867AbjHYMfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64300213A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAEB167B95
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14D4C433C9;
        Fri, 25 Aug 2023 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966928;
        bh=cEdpf8nj4L+tEbajYHm9fRowrvMGmi0iB9qhJQOyd10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqfWndFzMKyyQi9w1WPl655TawH43a8FJ2KpZ1GmRAq2L5n82x1q0LNWdmm8YcsCJ
         sbeFzEog9rEPu3eN4YiPHZG0OtnoWgqgw3HeuOhKlI8zmPDBZQ54O4SwNnNgKF7ov2
         F1R76PlNOq3MWqq9I7C3jnIolN61Moq2BSGlL4CbqmW7NDMsK7GSF1w1vdVhaKW9+N
         LOphDpZmpjYCfu6LNdPVivNgIZcwR76oB1SZNmEofcoiU1UMhbQ5649SkvHxFIRd0W
         hTUgF8xOCkMjtxX2cBXpLADlSHPgNbN6bue9uTV6b032pB+NfssR71tzOAJIMgJTGn
         kygCbsHnP7C+A==
From:   Will Deacon <will@kernel.org>
To:     jonathan.cameron@huawei.com, yangyicong@hisilicon.com,
        Jijie Shao <shaojijie@huawei.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, shenjian15@huawei.com,
        chenhao418@huawei.com, linux-arm-kernel@lists.infradead.org,
        liuyonglong@huawei.com, wangjie125@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: Update HiSilicon PMU maintainers
Date:   Fri, 25 Aug 2023 13:35:14 +0100
Message-Id: <169287588777.1251845.16915119599520165758.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230824024135.1291459-1-shaojijie@huawei.com>
References: <20230824024135.1291459-1-shaojijie@huawei.com>
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

On Thu, 24 Aug 2023 10:41:35 +0800, Jijie Shao wrote:
> Since Guangbin and Shaokun have left HiSilicon and will no longer
> maintain the drivers, update the maintainer information and
> thanks for their work.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: Update HiSilicon PMU maintainers
      https://git.kernel.org/will/c/21b61fe48c2f 

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
