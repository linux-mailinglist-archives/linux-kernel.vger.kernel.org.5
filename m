Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AC763D39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGZRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:07:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB282E4F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:07:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A502F4;
        Wed, 26 Jul 2023 10:07:51 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 327FC3F67D;
        Wed, 26 Jul 2023 10:07:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org, James Clark <james.clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Fix all W=1 build warnings
Date:   Wed, 26 Jul 2023 18:06:57 +0100
Message-Id: <169039093920.549048.3665369081970026970.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725140604.1350406-1-james.clark@arm.com>
References: <20230725140604.1350406-1-james.clark@arm.com>
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

On Tue, 25 Jul 2023 15:06:04 +0100, James Clark wrote:
> The kernel test robot looks for new warnings in a W=1 build, so fix all
> the existing warnings to make it easier to spot new ones when building
> locally.
> 
> The fixes are for undocumented function arguments and an incorrect doc
> style.
> 
> [...]

Applied, thanks!

[1/1] coresight: Fix all W=1 build warnings
      https://git.kernel.org/coresight/c/04e8429c5b4f644257fe64db3403205a7a41e33b

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
