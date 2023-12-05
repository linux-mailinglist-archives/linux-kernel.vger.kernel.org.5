Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02C9805BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjLERRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjLERRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:17:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414C1A5;
        Tue,  5 Dec 2023 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rZWO8O3rbEJ89oVb0TW+xEKhVkIpjIUUnu1HN5v2x/A=; b=nWU9bPuzRIs1NBesKFM+yxaRSy
        yJD+9m9ybkN79+xyYan3g0+uPzCswjbsi5IZr97QDbzh6PBN9qG1HZi6hHDozPabO5T4iECywogQZ
        aw2PvPV4+bcBVdGG2ewNFdKup3Bw+zCsOdJndw+g2WyCm08flD9L5dTlV3duyOoFjuy+FD4Lnd1cS
        pPnn8VnUdYISvdW10TB2AFoR2d+AGqcnVK/LKKcChhp8lhTZ9tj/au+yfsban4WS8JJ33C+tariO8
        DqZTsJi6PvCLvC6xyZ2bkX4Dg9ZJxhH5I+OC1Ybqnz/vqESHy8qk2n5a3wPIeQnLA/3fA/V9dAj0f
        6hYyLxLQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAZ3G-008159-10;
        Tue, 05 Dec 2023 17:17:42 +0000
Message-ID: <50d8f1dd-4df2-446a-bd82-47d96637b507@infradead.org>
Date:   Tue, 5 Dec 2023 09:17:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Dec 5 (soc/qcom/qcom_stats)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20231205135708.4a5a8413@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231205135708.4a5a8413@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 18:57, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231204:
> 

on powerpc 32-bit:

ERROR: modpost: "__udivdi3" [drivers/soc/qcom/qcom_stats.ko] undefined!


-- 
~Randy
