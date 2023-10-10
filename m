Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFA7BF053
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379339AbjJJBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379277AbjJJBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:33:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598FA8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:33:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5F3C433C8;
        Tue, 10 Oct 2023 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696901607;
        bh=eGsp9/T6AgDMD7GkgtTAVxyPrD/DSIMJzyoXuo9NnEg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RSbezX6ZUdEhKvcV40mbAmBg+ELQIGIiiy0HZJ0EsaB7TNIBfe24HWb0OYF0gB/Aq
         61p8H0FV783cAnuu6IGWgP9D3iwk9XWMMUgzUKDTWgdrt8S7gfhlRssm8C6KmCKGnS
         cuvxrcVC+H9zofp/aiS2JAeQAR4zSHzlLcoRwxnvqdQtUFJxKXCua1OSpe0PkeCBm2
         HgHpsedveENpXASiEKsFwNM33TEsffJni0cKwEPnRO7Qs1ynjxcyMym5sFQT+GFlbL
         GgBo/zLYLbKIvNcEZp0YQkWhX0tx76mfviVxe71nNYLHadDUn6IrhJdJTupmcNQuh3
         G89pqYnEssZww==
Message-ID: <f8ae6ba0-7dee-3dc2-1e52-5da101c10c08@kernel.org>
Date:   Tue, 10 Oct 2023 09:33:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: use proper address entry count
 for direct nodes
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231009202917.1835899-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231009202917.1835899-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/10 4:29, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
