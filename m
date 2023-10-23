Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F387D3708
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjJWMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjJWMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:23:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47264100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TXfXNzRhL196xoiQqgSt+hqYMruKWHho8UyfmKsrRhA=; b=MNnHhYwtUa+2nYdXCXWiC6Ty6W
        HkYSqKCUzjQHrKRqCzn/m9qaw1RF6B5RsQIAksvBuTkUbWRFnrFMnTW5Wx+Z2fo/BNIPErLuyHa4X
        Y9CJoA6+9iXE+ADGlzTuuOIJBv/WXEUT0qC9N2BskWi4bi5TNXPnqEaFUzu0MpkS60+1RIfjOdFFS
        Yfgrfjuo7PeNS47p0JoVjPMUhDN2pPMvuUlvFQuI1W/ybo+cuLxTYQ6/bkq95K9G/EF4guIi1eAxa
        nanOX5IEr565cUprCcsAT7d5kSFJQxEBfTgGUpd3r7+Usjd8qpdk7f3/avrUxvYUejJiukicqdsn1
        wgTHY/Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qutxu-00DkBR-OM; Mon, 23 Oct 2023 12:23:26 +0000
Date:   Mon, 23 Oct 2023 13:23:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
Message-ID: <ZTZlvlpQYGsYPHco@casper.infradead.org>
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
 <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
 <ZSq3iuuGy7zSl4sz@casper.infradead.org>
 <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
 <CAJHePoZVMMCcUNKbg5f9VrYo-x5E_rU1piQGHi67ZuY4Pyj4bg@mail.gmail.com>
 <5cd5b88ec8f4500a716aa8b96d27d44e96ed65bf.camel@HansenPartnership.com>
 <CAJHePoayC+RUk4gCCYACRXguuXfeWFvg5cyiCwNi-YxC3-UOLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHePoayC+RUk4gCCYACRXguuXfeWFvg5cyiCwNi-YxC3-UOLw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:08:49PM +0500, Muhammad Muzammil wrote:
> Can anyone approve this patch?

Please send a v2 with the rely -> relies fix included.
