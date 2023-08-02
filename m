Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487C676CC32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjHBMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjHBMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:00:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B892D5F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:00:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F20B113E;
        Wed,  2 Aug 2023 05:00:47 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4B933F6C4;
        Wed,  2 Aug 2023 05:00:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        coresight@lists.linaro.org
Subject: Re: [PATCH] coresight: trbe: Directly use ID_AA64DFR0_EL1_TraceBuffer_IMP
Date:   Wed,  2 Aug 2023 12:59:56 +0100
Message-Id: <169097752830.649874.17955705611720266420.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802063658.1069813-1-anshuman.khandual@arm.com>
References: <20230802063658.1069813-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 12:06:58 +0530, Anshuman Khandual wrote:
> is_trbe_available() checks for the TRBE support via extracting TraceBuffer
> field value from ID_AA64DFR0_EL1, and ensures that it is implemented. This
> replaces the open encoding '0b0001' with 'ID_AA64DFR0_EL1_TraceBuffer_IMP'
> which is now available via sysreg tools. Functional change is not intended.
> 
> 

Applied, thanks!

[1/1] coresight: trbe: Directly use ID_AA64DFR0_EL1_TraceBuffer_IMP
      https://git.kernel.org/coresight/c/c00701125cf379f8ce9a4c98cb3cbf9edc3a5672

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
