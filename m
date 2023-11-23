Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5437F6329
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbjKWPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbjKWPiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:38:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0921AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s7ekhSuoXxWlw3uFMenhrsDmT0xI7DRa/z1sU8Z+EW4=; b=L/HubkwKeFULvuKpdH+LQqMTRj
        e8DkQyvYc9norxdz5rus6WwdDaASMKeKSWAi7uP6vG3pbZr32kgA5AoZVQdeA2Jti4KHWSVd2LTYa
        +IBv2B9FqQ1xgGlwzRFOoa4Vqy5OG7uOkzuhqnOkuAMEUjJ1tQ6Dp4jqtQz6XyQ0fOv9k9xNXQJyG
        GJtD1L3S37xtaAagdZIDmO7t+ah4bg7tVgTFUmxbAiWnRnVp58bE4fkvKVTUD5CR/TL4nouVog+R9
        PNK5JT9pic/gBOT/LNYY2DdQpD2Gn+q9cDWOEad1/zTsSqBDPOsA1NLNnWkfHdU9XG4K6AtebfDbm
        2zJgIgxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6BmU-007ftN-2B; Thu, 23 Nov 2023 15:38:18 +0000
Date:   Thu, 23 Nov 2023 15:38:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <ZV9x6qZ5z8YTvTC4@casper.infradead.org>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV7eHE2Fxb75oRpG@archie.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV7eHE2Fxb75oRpG@archie.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:07:40PM +0700, Bagas Sanjaya wrote:
> Anyway, I'm adding this regression to regzbot:
> 
> #regzbot ^introduced: v6.0..v6.1

this is not a regression.  close it, you idiot.


