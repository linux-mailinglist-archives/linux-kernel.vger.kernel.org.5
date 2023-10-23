Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4B7D3A99
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJWPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:23:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0193
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9lZs69Vxt1Y/639BD76HQcQPNwVZLE/2hQa7QNs6Ms0=; b=BGwnqZnYPJ3zkjDBcj5Jm32Fnm
        6KRlCEYo8QFwVxV+Gso1KfR8XpWk7jqSBg2f8aoUL726FehLAcWj1NT763wj1Pv2kFxu1WGT7vC3T
        75YMSX1+HXqHmubJ3SEaq6ep0iuT5U5rLzsRGPhlaKYCKOoayowlcO1kgeJiQay3KUEJRWhyAlyj+
        lqZnn74xZUNyDGsavrGfZu/G7LxVBHWHAlIl7PXGlhAnNeqOwX51SLxWRD8G/zaNCX5pYzOra5l0t
        Wm9k1iDEGpgXjkbEebxdLORNgCrkA2ZMwz/Lqiwfml5lfBSFGp+UR4sRrYOBMuqOqCT7Hx1ijHLEU
        ZAv3nFUg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1quwlo-007g3x-0I;
        Mon, 23 Oct 2023 15:23:08 +0000
Message-ID: <f6f013d5-721a-4a62-b987-051a042f3347@infradead.org>
Date:   Mon, 23 Oct 2023 08:23:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Fixed multiple typos in multiple files
Content-Language: en-US
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        willy@infradead.org, James.Bottomley@hansenpartnership.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231023124300.36829-1-m.muzzammilashraf@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231023124300.36829-1-m.muzzammilashraf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/23/23 05:43, Muhammad Muzammil wrote:
>     memcontrol.c: Fixed type 'relies'

                          typo

> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> 
> changes since v1:
> 
> mm: Fixed multiple typos in multiple files
> 
>     debug_vm_pgtable.c: Fixed typo
>     internal.h: Fixed typo
>     memcontrol.c: Fixed typo
>     mmap.c: Fixed typo

The "changes since ..." should be after the "---" line (below here),
but the changes since v1 are just the update of rely -> relies.
The full list of changes should be in the (upper) patch description.

I guess it's up to Andrew whether he wants you to send a v3 of this patch.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  mm/debug_vm_pgtable.c | 4 ++--
>  mm/internal.h         | 2 +-
>  mm/memcontrol.c       | 4 ++--
>  mm/mmap.c             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 48e329ea5ba3..e651500e597a 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1322,8 +1322,8 @@ static int __init debug_vm_pgtable(void)
>  	 * true irrespective of the starting protection value for a
>  	 * given page table entry.
>  	 *
> -	 * Protection based vm_flags combinatins are always linear
> -	 * and increasing i.e starting from VM_NONE and going upto
> +	 * Protection based vm_flags combinations are always linear
> +	 * and increasing i.e starting from VM_NONE and going up to
>  	 * (VM_SHARED | READ | WRITE | EXEC).
>  	 */
>  #define VM_FLAGS_START	(VM_NONE)
> diff --git a/mm/internal.h b/mm/internal.h
> index b52a526d239d..b61034bd50f5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -601,7 +601,7 @@ extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>   * range.
>   * "fully mapped" means all the pages of folio is associated with the page
>   * table of range while this function just check whether the folio range is
> - * within the range [start, end). Funcation caller nees to do page table
> + * within the range [start, end). Function caller needs to do page table
>   * check if it cares about the page table association.
>   *
>   * Typical usage (like mlock or madvise) is:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be2ad117515e..929b4e0f4669 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -842,7 +842,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	memcg = pn->memcg;
>  
>  	/*
> -	 * The caller from rmap relay on disabled preemption becase they never
> +	 * The caller from rmap relies on disabled preemption because they never
>  	 * update their counter from in-interrupt context. For these two
>  	 * counters we check that the update is never performed from an
>  	 * interrupt context while other caller need to have disabled interrupt.
> @@ -8104,7 +8104,7 @@ static struct cftype memsw_files[] = {
>   *
>   * This doesn't check for specific headroom, and it is not atomic
>   * either. But with zswap, the size of the allocation is only known
> - * once compression has occured, and this optimistic pre-check avoids
> + * once compression has occurred, and this optimistic pre-check avoids
>   * spending cycles on compression when there is already no room left
>   * or zswap is disabled altogether somewhere in the hierarchy.
>   */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b59f5e26b6fb..27539ffe2048 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1223,7 +1223,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	 * Does the application expect PROT_READ to imply PROT_EXEC?
>  	 *
>  	 * (the exception is when the underlying filesystem is noexec
> -	 *  mounted, in which case we dont add PROT_EXEC.)
> +	 *  mounted, in which case we don't add PROT_EXEC.)
>  	 */
>  	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
>  		if (!(file && path_noexec(&file->f_path)))

-- 
~Randy
