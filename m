Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74C782892
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjHUMHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjHUMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:07:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B0BE;
        Mon, 21 Aug 2023 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JqoZh4j5vDPGDIYjMUoDWXygkriwUyqpdmDkXxwFKUY=; b=kHbNoNIQmnKW3eiIhvfmiMTBQw
        oGMjbNzTExz6otTNkAShMEu1bvig7HkVfaLiH3BkeGUlYEpazVo19ETIVdSKj7i/+ic2BJzrySwRu
        31dfjjQmFXsOgvfi0fs5a5IYZFoCLBXMYw7EWZ4VoymRmwOwPbLsDs6+9+V9iSmrIZnMWw46vLokd
        mjo34ABh0rV3PhAw94bwGG8IusAbeg0mr4b0Iz9KIn1Za0R9vRNu+GYesMlH2sI0ZzfH6IOgK5xeI
        SBHkHf06PIe4tBkM1YjG1Xc2kpyxnAsqAHP04IZHs24hx1E5TTVdRFRv4xvdT5BgcxvEMwVcAsl52
        laC4ZHOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY3h4-00A50W-Jp; Mon, 21 Aug 2023 12:07:38 +0000
Date:   Mon, 21 Aug 2023 13:07:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
Message-ID: <ZONTiijMLWbt6naQ@casper.infradead.org>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <ZN65iiRiSLmXz89k@casper.infradead.org>
 <87ttss7q8o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttss7q8o.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:29:27AM +0300, Jani Nikula wrote:
> On Fri, 18 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> > but you might have (eg)
> >
> > Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>
> >
> > and then when working for another sponsor:
> >
> > Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>
> 
> Just an observation, git shortlog -s/-se groups/distinguishes,
> respectively, the author and sponsor in Laurent's approach. Not so with
> Matthew's approach.

Hm?

$ git shortlog -s next-20230817..
     1  Matthew Wilcox (Novartis)
    25  Matthew Wilcox (Oracle)

$ git shortlog -se next-20230817..
     1  Matthew Wilcox (Novartis) <willy@infradead.org>
    25  Matthew Wilcox (Oracle) <willy@infradead.org>

