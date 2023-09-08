Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF07798811
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbjIHNpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbjIHNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:45:41 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A2231BF4;
        Fri,  8 Sep 2023 06:45:28 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qebnV-0005jo-00; Fri, 08 Sep 2023 15:45:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 32113C0508; Fri,  8 Sep 2023 15:41:23 +0200 (CEST)
Date:   Fri, 8 Sep 2023 15:41:23 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, manuel.lauss@gmail.com,
        arnd@arndb.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MIPS: Alchemy: only build mmc support helpers if au1xmmc
 is enabled
Message-ID: <ZPskg3QTKDDKTR7u@alpha.franken.de>
References: <20230905070656.196274-1-hch@lst.de>
 <d8e0dd0f-ce37-2dbf-8ac3-a1e26a18cf45@infradead.org>
 <20230908081634.GC8240@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908081634.GC8240@lst.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:16:34AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 05, 2023 at 06:04:18PM -0700, Randy Dunlap wrote:
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> Thomas, given that this is mips arch code, it's probably best if you
> pick it up.

sure, will apply it soon.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
