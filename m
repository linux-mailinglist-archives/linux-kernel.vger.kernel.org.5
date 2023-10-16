Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA207CB6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjJPW6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjJPW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:58:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1D1683
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:58:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB13B1FB;
        Mon, 16 Oct 2023 15:59:29 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C32B3F64C;
        Mon, 16 Oct 2023 15:58:48 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable from sysfs
Date:   Mon, 16 Oct 2023 23:58:42 +0100
Message-Id: <169749698411.709203.13102549101679987842.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818082112.554638-1-anshuman.khandual@arm.com>
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 13:51:12 +0530, Anshuman Khandual wrote:
> Currently TMC-ETR automatically selects the buffer mode from all available
> methods in the following sequentially fallback manner - also in that order.
> 
> 1. FLAT mode with or without IOMMU
> 2. TMC-ETR-SG (scatter gather) mode when available
> 3. CATU mode when available
> 
> [...]

Applied, thanks!

[1/1] coresight: tmc: Make etr buffer mode user configurable from sysfs
      https://git.kernel.org/coresight/c/efb05212a230

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
