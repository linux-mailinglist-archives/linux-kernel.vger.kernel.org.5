Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB007DF9B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjKBSOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjKBSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:14:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E4D5A;
        Thu,  2 Nov 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EF1P+qhTkD1fVrPfz+oRkiDrF1SkoAXGdb5N1IjnSOg=; b=FnYVuw9YNSDZynrJoQgqPMdVrC
        dMFvDec5GzfS6kWF2/iUXdRkzh1L5v/b5AjWJU/NWcWdEu17ZEAd7Im49LXryFC7XRnKKF7L37O9d
        7WHvWsFZPfmW+O3a8DsxXWhoYlS9V9Hdy35F5Srq+NnBUP/JkW4dGY1pHxusYWPhPtoG7oDq3+tKn
        PLm+C62H+rmeT+ObTIlbwYzA+NJboGVAv24MpRI6lWGyHpUZuZyO+B2Bzbq1E6gka5O5I+BqW4jYh
        a++vuuZJPnjGH50PZHdf25NsaL/7ejHqctyl5iWs6KjrF2jMsEQStV6A8R+id7AI3Hq3Yz8JMIstI
        HKR3l7vA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qycBt-000mDr-4B; Thu, 02 Nov 2023 18:13:13 +0000
Date:   Thu, 2 Nov 2023 18:13:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sourav Panda <souravpanda@google.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, weixugc@google.com
Subject: Re: [PATCH v5 0/1] mm: report per-page metadata information
Message-ID: <ZUPmufo42pJ2i3uw@casper.infradead.org>
References: <20231101230816.1459373-1-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101230816.1459373-1-souravpanda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 04:08:15PM -0700, Sourav Panda wrote:
> Changelog:
> v5:

SLOW DOWN!

You've sent three versions in two days.  This is bad netiquette.
I don't want to see a new version for at least a week.
