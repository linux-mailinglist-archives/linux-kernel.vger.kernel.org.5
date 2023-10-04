Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5D7B7CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbjJDKI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJDKIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:08:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34583;
        Wed,  4 Oct 2023 03:08:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61011C433C8;
        Wed,  4 Oct 2023 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696414130;
        bh=ziJwjYvWmDrx/OZW30jWykdrY4rTHf3r4/nycmHupnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AA1PigxVcMFjdOwjlC/ZxO4N9pjUxDEi22309Fg2ONAiEFRubviYO9ijs4WFQID+o
         C8b74s55iQYzUvFimJL0OCSOkb+SI6HLOHjj0OA3tyuvheiciNbFjKQydZXojNViW6
         0QhQh95Taok7G9ZXVCsUdpzOsswki5TxGJ25zCGvAFhZ03+EkOpNbk3v4zLfMfKzRZ
         N7+CS3vId1EXUuImzOUtN2e79D4b09vutpnpYjcEUnb/OiYhT4Ly0ivDd5HKzm2W2E
         5r+LkuQnz9dVy5v+w37S+x8eg19CcopCvKqs/LOcRwnoPVjjN2cwETRyONpbw4MjHr
         O8zweqAxnmGGQ==
Date:   Wed, 4 Oct 2023 06:08:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     stable@vger.kernel.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jgg@nvidia.com, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH][6.5, 6.1, 5.15] iommu/arm-smmu-v3: Fix soft lockup
 triggered by arm_smmu_mm_invalidate_range
Message-ID: <ZR05sWtiMmM0w2sb@sashalap>
References: <20231003233549.33678-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231003233549.33678-1-nicolinc@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:35:49PM -0700, Nicolin Chen wrote:
>commit d5afb4b47e13161b3f33904d45110f9e6463bad6 upstream.

Queued up, thanks!

We don't need the addition of a stable tag here as the bot suggests,
it's just being silly...

-- 
Thanks,
Sasha
