Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04B770022
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHDMXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHDMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:23:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 423F446AA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:23:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911F31007;
        Fri,  4 Aug 2023 05:24:04 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AD4C3F5A1;
        Fri,  4 Aug 2023 05:23:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        aidapala@qti.qualcomm.com, souvik.chakravarty@arm.com,
        satyakim@qti.qualcomm.com, atouzni@qti.qualcomm.com
Subject: Re: [PATCH 0/2] Introduce SCMI v3.2 PERF Indexing support
Date:   Fri,  4 Aug 2023 13:23:17 +0100
Message-ID: <169115173585.3256098.11692682854165418378.b4-ty@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717161246.1761777-1-cristian.marussi@arm.com>
References: <20230717161246.1761777-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 17:12:44 +0100, Cristian Marussi wrote:
> this small series adds support for the upcoming optional support for
> Performance domains Level Indexing mode.
> 
> PERF Protocol Level Indexing mode was introduced in SCMI V3.2 [1] as an
> optional way to describe Performance levels using a non-linear scale.
> 
> SCMI platform can now optionally declare a Performance domain as
> supporting Level Indexing and report when queried a level-index and an
> indicative frequency that do not need to fit into a linear-scale.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/2] firmware: arm_scmi: Harden PERF domain info access
      https://git.kernel.org/sudeep.holla/c/ecbe7c54a822
[2/2] firmware: arm_scmi: Add v3.2 PERF Level Indexing mode support
      https://git.kernel.org/sudeep.holla/c/6e6d9a1ecb8a
--
Regards,
Sudeep

