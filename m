Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75B67E4686
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjKGRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKGRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:02:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7295
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:02:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A155CC433C7;
        Tue,  7 Nov 2023 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699376570;
        bh=QZ1z+vd2Ki15Htt0z+L7XbvTzj8iKvqYoySqly1vFz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCs6Ksqed8kvADL8jZeNtcnFX66LqYatqEvbrXFgVVQe1cgKlFEXOiqnl95O28TRh
         yZ1GIRTz1v9iPw/NZX6TLLDLMPT9I1VXWLKEuz2nHiyRNpdh9lBJEyHReA5BLsVhdG
         W8RyGoXLx/2sdMk3qc4f0sK9tRkdUaBHjmTqcXblitcP8Cf8TCr1wM2Bg3rxkdvALm
         Mc9TI6tDcblXJohWtzuF8UAyYPVvE/5i/7PBb5Z39LnogtxxiOIiTdEaih5G/zgOS8
         gyQY7IrZYhcw6Jg2H8jyWEE3eVU7Ds+3Wmd2ZQOfNWVVshWNEAAsstaREOs9hiha6l
         Sl4y/BS2jWdFg==
Date:   Tue, 7 Nov 2023 09:02:49 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Cindy Lu <lulu@redhat.com>,
        jasowang@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107090249.7e488896@kernel.org>
In-Reply-To: <20231107082343-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
        <20231107022847-mutt-send-email-mst@kernel.org>
        <20231107124902.GJ4488@nvidia.com>
        <20231107082343-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 08:28:32 -0500 Michael S. Tsirkin wrote:
> I am always trying to convince people to post RFCs early
> instead of working for months behind closed doors only
> to be told to rewrite everything in Rust.
> 
> Why does it have to be internal to a specific company?
> I see Yi Liu from Intel is helping Cindy get it into shape
> and that's classic open source ethos.

+1, FWIW.
