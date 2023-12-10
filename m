Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D080BD5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjLJVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:32:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A42BCF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mgSDI1NryzOYIaxbcEklzJagqTqe3KqQUfu7LyQ1Vac=; b=iR7OUu/54aO8FZj1dt8XRv1LsT
        Op/wC9tiZntQdZiIy4htZ2E78U1QD1h7j24eAMmYcLyREPy6pHPHwNwKvia91IjTUF8zGKopjweP6
        H1dMGHxind1aKrDA3OS7dFEpAms3+sg4sZVum8WoODMAqywuzFe3vyzue2qIHB340kWaUvSUki3II
        95ukiuu40Zx/8tgL5kobz3NHXzb6KV+G+l8rUOdP3HrK+CI6pVXoAEG6QZ7tZa3h09lA4Y2qY9W/Q
        fKhzDcF2Hf9dIfK7owCunUqDSMPjVqNgnwWHAvSha60gqG/83P57+8VWmFB652zHjX0PkSisJn7Fy
        SGJetDEg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rCRQ0-003W0T-2m;
        Sun, 10 Dec 2023 21:32:56 +0000
Message-ID: <48ffebd8-8803-4379-b972-4072e4366abc@infradead.org>
Date:   Sun, 10 Dec 2023 13:32:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: fix typos/spellos etc.
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231210063839.29967-1-rdunlap@infradead.org>
 <ZXYp60O0qxvPmuHu@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZXYp60O0qxvPmuHu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/23 13:13, Matthew Wilcox wrote:
> On Sat, Dec 09, 2023 at 10:38:39PM -0800, Randy Dunlap wrote:
>> - * mas_topiary_node() - Dispose of a singe node
>> + * mas_topiary_node() - Dispose of a single node
> 
> That's all well and good, but how do we dispose of singed nodes now?
> 

Yes, that leaves a problem here, but I'm sure that Liam can come up
with something.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
