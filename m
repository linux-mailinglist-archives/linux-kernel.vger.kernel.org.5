Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A677079B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHDSLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjHDSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E26526F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A17FE620E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 18:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85592C433C9;
        Fri,  4 Aug 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691172621;
        bh=/NsTFoOClyyE5ayE/n5NmN2ujIMfyESu9tD4Y/l7j38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oujgugVQ1LckYZK+39m5eg3MSCuiscMdR2cPmuN/KTD6vPatx41XrFePNNTkmm8e0
         xfnhYVX4iwN52+R3LfsUM4Hgh3mgTFiLxMFHMWc9zEcGio432eNtlLNsc6jePVv9Us
         hnhrR6NMJJmshK5fxvffE7cdPgNOrlP53jbkPMGmOgyNadVHoZw4I0CnEC/6KHLKvn
         d+JRZgoZw4TPWGRQa9GhMLw1d9VrGDFqf2lc/JFaBo62uLuCd/Hoe32HgK9heAl6fs
         34KRIUB9zv96awDTmcTNJ7n1cqTlxZUPQ47W1TVmyk/KVykxKDtyEbdFVSUk5IXW3X
         7vGiJzULwtMJw==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf: pmuv3: Remove comments from armv8pmu_[enable|disable]_event()
Date:   Fri,  4 Aug 2023 19:10:11 +0100
Message-Id: <169116623778.146146.16541387857288283453.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230802090853.1190391-1-anshuman.khandual@arm.com>
References: <20230802090853.1190391-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 14:38:53 +0530, Anshuman Khandual wrote:
> The comments in armv8pmu_[enable|disable]_event() are blindingly obvious,
> and does not contribute in making things any better. Let's drop them off.
> Functional change is not intended.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: pmuv3: Remove comments from armv8pmu_[enable|disable]_event()
      https://git.kernel.org/will/c/90d68677226a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
