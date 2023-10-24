Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F407D4411
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJXAee convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 20:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjJXAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:34:33 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49CF93
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:34:30 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qv5MK-00026L-0V;
        Mon, 23 Oct 2023 20:33:24 -0400
Message-ID: <0915cf18732f9d0bf0907a6e8f14d2782e2b6bd7.camel@surriel.com>
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix reference to nonexistent file
From:   Rik van Riel <riel@surriel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>
Date:   Mon, 23 Oct 2023 20:33:23 -0400
In-Reply-To: <20231022185619.919397-1-vegard.nossum@oracle.com>
References: <20231022185619.919397-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-22 at 20:56 +0200, Vegard Nossum wrote:
> The directory this file is in was renamed but the reference didn't
> get updated. Fix it.
> 
> Fixes: ee65728e103b ("docs: rename Documentation/vm to
> Documentation/mm")
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Wu XiangCheng <bobwxc@email.cn>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> 
Reviewed-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
