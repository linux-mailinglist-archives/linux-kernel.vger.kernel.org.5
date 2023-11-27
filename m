Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2B7F9778
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjK0CX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0CX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:23:57 -0500
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD920C5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:24:01 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701051839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03AItCkX6f50QX8qGn4DUIQ3gtnorhO0EzC7fFvxu9o=;
        b=lnMulVAX7aD60/QM35jBh7ZD89gHMGRie9iLFBXGgAYwkXlhTa2WU+wgrbbnBBWmlSoeY2
        M/GqI0Bi/DBMzVVS5np01XjGifqrhUffNOFUmQc3C8NygbgPOqM/FUoHRlVM+plt73/yi3
        opuAaP465b96xqDi8wzVUPkouPQIFpw=
Mime-Version: 1.0
Subject: Re: [PATCH v2] fs/Kconfig: Make hugetlbfs a menuconfig
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231124151902.1075697-1-peterx@redhat.com>
Date:   Mon, 27 Nov 2023 10:23:15 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F55FA767-9951-4CBB-B4C2-DFD37B33EF91@linux.dev>
References: <20231124151902.1075697-1-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2023, at 23:19, Peter Xu <peterx@redhat.com> wrote:
> 
> Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
> is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
> itself, under "Pesudo filesystems".
> 
> Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
> into a menuconfig.  When moving it, fix a typo 'v' spot by Randy.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

