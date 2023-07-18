Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2897B757C37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjGRMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGRMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:51:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014BE7E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ofwhn/uhYQXSFa1NvJBqfJfTzDRTFmSNId+wS/oJpxQ=; b=pLVlfBWDFbh1jkXHsDCfl+SHo8
        JsnWe6CeY6jjOlmIDPzleqEYaw5SWWZCUxLn2GxcQSDD4X1rQwlfKnn/RjrOl8EohwRa6HZSRmmKV
        eVETLxgIRgW8JndWX5QN98HuKGtHHQzdrom7XRSfVeJ2PAt2UdzW+4XVKjdvTeZ42P8sh8SqLpvb4
        wq//MEVRj8jSQAPYFe5TbL3hWYFzDyVUBuzt7Xd4Fdtd92yxbF2gINFhx8qzNOYZVXGm3u1cyF2FM
        cfqRORvh+T6z8GU14PnPkOJsnawgfqxqrejpxXg7VEDRc/xNSqNjc+go04/7RLiP2thLNt0H1EYZ3
        Yruof0uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLkAH-004vg1-8j; Tue, 18 Jul 2023 12:50:53 +0000
Date:   Tue, 18 Jul 2023 13:50:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: correct stale comment of rmap_walk_anon and
 rmap_walk_file
Message-ID: <ZLaKrbGXI2bvtUsh@casper.infradead.org>
References: <20230718092136.1935789-1-shikemeng@huaweicloud.com>
 <76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com>
 <ZLaI/jfVLVZfr5pc@casper.infradead.org>
 <412ad509-0312-726a-9c1c-6d6e6df8e98f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412ad509-0312-726a-9c1c-6d6e6df8e98f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:46:07PM +0200, David Hildenbrand wrote:
> https://lore.kernel.org/all/20230718092136.1935789-1-shikemeng@huaweicloud.com/T/#u

Looks like kvack.org rejected or delayed it.  Anyway, patch is fine, so

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
