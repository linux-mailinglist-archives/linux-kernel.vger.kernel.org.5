Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE47E422C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjKGO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjKGO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:56:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E2F113
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:56:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4F0C433C7;
        Tue,  7 Nov 2023 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699368998;
        bh=l1ZYfffC8O+aReYdWjMaCT0Mwo0ccB4D+3F/B6MBj3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M7YFzhYjMZlrzGd8ah5eKsEd7JrZ2FMPduPsfxDC1cHTGkX8V+fF/2pUn2lYZWc+D
         gJIy/XHWSx30Yw6jmVrUspsPkck2iIh3NSQXMb2gA8lYXeYD+BL9KHkuZqmMlU8YBJ
         GrI9bpnkW6dl3oSHEmT3zH0RkL9s8lSD27Zk2Ua+JFeSV/dQb6PVCdx6p190mTIftx
         eJvCCJ4TAs8eSWuwerOGQvadl3X7zHtAqRZorL9jjP2BXfM4ZJcaiRc03D/JY+JNAK
         6P749INlnfnaD/I4u5nDnwqXfTsDWXChDLOv5hCMrOjbQFHJ+X95z5UDzX81q2pSzo
         on7nFlLK3l4SQ==
Message-ID: <86cf3a62-975c-92cf-672d-5103416592d9@kernel.org>
Date:   Tue, 7 Nov 2023 22:56:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] f2fs: the name of a struct is wrong in a comment.
Content-Language: en-US
To:     dslab@lzu.edu.cn, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Hubin <yanghb2019@lzu.edu.cn>,
        Qian Haolai <qianhl2023@lzu.edu.cn>
References: <20231104074501.13998-1-dslab@lzu.edu.cn>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231104074501.13998-1-dslab@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/4 15:45, dslab@lzu.edu.cn wrote:
> From: Yang Hubin <yanghb2019@lzu.edu.cn>
> 
> The macro SUMMARY_SIZE represents the size of the struct f2fs_summary,
> 
> instead of the size of the struct summary.
> 
> Signed-off-by: Yang Hubin <yanghb2019@lzu.edu.cn>
> Signed-off-by: Qian Haolai <qianhl2023@lzu.edu.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
