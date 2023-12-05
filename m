Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8448048ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjLEEzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjLEEzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:55:17 -0500
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15ACD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:55:23 -0800 (PST)
Date:   Mon, 4 Dec 2023 23:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701752122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DalfH2rgAcD/bwZb6Yo032ctkov4QXdhPwXLALYf4QI=;
        b=Vlq5eoHQDEdxoNJhm5qn78tDsUjgN8JltNdOaz/xBMe6iF+m7weVVNP15VHGaOvnqBIMI4
        vQNGtikGoEvWg1Vy+A7AeT7LQgfsJ3/AeaZJmJqNLgw+WxQS7EshzdrSzA0Oad0thki4u8
        aozhOQCD9NHPXb6pbnd4yKlc8BshAGM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Krueger <stefan.krueger@aei.mpg.de>
Subject: Re: [bcachefs] [bug]: missing subvolume 0
Message-ID: <20231205045518.5qje7doafm2fjroa@moria.home.lan>
References: <5cc5076e-3a85-48e2-b75f-a3d1021f531e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc5076e-3a85-48e2-b75f-a3d1021f531e@molgen.mpg.de>
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

On Mon, Dec 04, 2023 at 12:03:26PM +0100, Donald Buczek wrote:
> Reporting to maintainer.pl list, hope that's correct?
> 
> Probably, this is a trivial one:
> Linux 6.7.0-rc4.

now fixed in the bcachefs-for-upstream branch, will be in
for-next/master shortly
