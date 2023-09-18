Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDC7A5473
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjIRUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjIRUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:52:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711368E;
        Mon, 18 Sep 2023 13:52:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F46C433C8;
        Mon, 18 Sep 2023 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695070327;
        bh=FM/e+9HNsj6WL+QzLvyQRkXOh67nb09Zq87aiKOG1q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pH8BCdYF/Yflrh8hB2gbeCZNc9siAwwWX8IncR/7W/YYbZOThKjjSk2Pi/6Oywguy
         j3Ep6STTZJf8R4pKFk6e3eRtd0+e5sjd/3fFDiaLWn9z7m5D6xrBW6DObkA8AinTqr
         pZ5A5F0FxCfrslRtZp2xTE+2jTFHTpxEtzwR5V+iUjqLyzOek2fRjP4GQ9NVKvvMdw
         bJmry0dl4nrYdz3L9uyXwGyu+X/RhcGQpUbQo2gOs2SnG4/nauXruHJKjhIz+i7giO
         uVsjBkom1+UtO5bMCp8AXrsVNMWrlZn0fFPNIIuwDCSe07sPepkZVWdrhvAGat6xoR
         z5LRiZ5hD8v5g==
Date:   Mon, 18 Sep 2023 13:52:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230918205206.GA348037@frogsfrogsfrogs>
References: <20230915093953.310503ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915093953.310503ee@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:39:53AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the iomap tree as a different commit
> (but the same patch):
> 
>   de5b0b257ee3 ("iomap: handle error conditions more gracefully in iomap_to_bh")
> 
> This is commit
> 
>   4aa8cdd5e523 ("iomap: handle error conditions more gracefully in iomap_to_bh")
> 
> in the iomap tree.

Christian, do you want to push this to Linus instead of me?  I've a
couple more fixes that I'm about to send out to fsdevel and could just
roll all the iomap stuff into a single branch... but if you were about
to this to Linus I don't mind letting that happen.

--D

> -- 
> Cheers,
> Stephen Rothwell


