Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D047ADC87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjIYP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjIYP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:59:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5750101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:59:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C89C433C8;
        Mon, 25 Sep 2023 15:59:15 +0000 (UTC)
Date:   Mon, 25 Sep 2023 16:59:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org, maz@kernel.org,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64/sysreg: Move TRFCR definitions to sysreg
Message-ID: <ZRGuUSkwKqeZ3+ot@arm.com>
References: <20230905102117.2011094-1-james.clark@arm.com>
 <20230905102117.2011094-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905102117.2011094-2-james.clark@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 11:21:14AM +0100, James Clark wrote:
> Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
> This also mirrors the previous definition so no code change is required.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I assume these patches would go in via the coresight tree.
