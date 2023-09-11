Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AF79BD01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358631AbjIKWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjIKJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:40:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ACB6EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:40:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8161D75;
        Mon, 11 Sep 2023 02:40:51 -0700 (PDT)
Received: from bogus (unknown [10.57.93.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3BF03F5A1;
        Mon, 11 Sep 2023 02:40:12 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:39:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ruidong Tian <tianruidong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, james.clark@arm.com,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jay Chen <jkchen@linux.alibaba.com>
Subject: Re: [PATCH] coresight: etm4x: Add ACPI id for THEAD YiTian SOC
Message-ID: <20230911093914.cqho4dyuekn5oe3l@bogus>
References: <20230911072509.126063-1-tianruidong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911072509.126063-1-tianruidong@linux.alibaba.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:25:09PM +0800, Ruidong Tian wrote:
> From: Jay Chen <jkchen@linux.alibaba.com>
> 
> Add support for detcting ETE device of THEAD YiTian SOC.
>

Are you trying to identify "THEAD YiTian" SoC here ? Or the standard
ARM Coresight ETMv4 ? Or does this THEAD YiTian SoC has a modified version
of ETMv4 which needs special handling in the driver ?


-- 
Regards,
Sudeep
