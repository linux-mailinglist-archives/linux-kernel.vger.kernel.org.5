Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFC7C75A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441821AbjJLSHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347362AbjJLSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:07:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B3B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:07:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A94C433C8;
        Thu, 12 Oct 2023 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697134021;
        bh=sTUN/S8uDSXmOtLaR38bGCwiAqCoUVYoh6JYKFIP1A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH0pl6E7hi3RBThDpDfoKqyo3pOV51mmXfcx22ueXnsN5QQBhkFkki7tcJ8/SZAUa
         eMA2JZQGzGG8amDFsO9y9e02NK/mtYNoQTrOmuGBR3J+BlIr4Q/ZF/e/XpY8tzBVY8
         T40TtWJmO7vX1ymRGuB632hvj+K+KGfznB5sXlLZPgpVI60I+BxLzaoG5szBJ4hOIV
         BvaiMHIcU90TCSdzoyEuUbqOjru0FPD9AHKvif3qWjC1+rscJTTT2yzsLKbNeOggnP
         QVP4QNU6i3cuILRm5lGq9N+OJ6XOaN5NYOwhvG00TZB+XpGJXTGrXx+CInzYgxzHvh
         cXv4T0IXdYvvA==
From:   Will Deacon <will@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/perf: Add ampere_cspmu to toctree to fix a build warning
Date:   Thu, 12 Oct 2023 19:06:45 +0100
Message-Id: <169711035718.620662.14569191392067573521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231012074103.3772114-1-ilkka@os.amperecomputing.com>
References: <20231012074103.3772114-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 00:41:03 -0700, Ilkka Koskinen wrote:
> Add ampere_cspmu to toctree in order to address the following warning
> produced when building documents:
> 
> 	Documentation/admin-guide/perf/ampere_cspmu.rst: WARNING: document isn't included in any toctree
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] docs/perf: Add ampere_cspmu to toctree to fix a build warning
      https://git.kernel.org/will/c/0abe7f61c28d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
