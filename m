Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137C4797364
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjIGPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjIGPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21C1A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C3DC32796;
        Thu,  7 Sep 2023 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694097836;
        bh=dDjV8SeoGYBfPPQVmgOlnn/0boD8+0AVtqtuPLpORLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=digxMZdAvqJOGdBqkmYwy0J3MJL9/PkXTCeZj87cOcKTvwGb+KXjqUKmHL50EgScT
         uPsIQVL/SbBqkPqs9Ss7AwZSa7PGZX36al1NzOy6ap0/q/gJODNDNx+7AjRey+cYB2
         MPXTehhBGSu4uPlA5+UBwnrZ1idLegjRompPgPqE=
Date:   Thu, 7 Sep 2023 15:43:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Type encoding info dropped from
 array name "byVT3253B0_"
Message-ID: <2023090724-trial-ipod-93d2@gregkh>
References: <ZPnLw+njcL/D391S@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPnLw+njcL/D391S@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 06:40:27PM +0530, Pavan Bobba wrote:
> Below array names updated as per coding guidelines:
> 
>    1.byVT3253B0_AGC4_RFMD2959
>    2.byVT3253B0_AIROHA2230
>    3.byVT3253B0_UW2451
>    4.byVT3253B0_AGC
> 
>    Conversions performed:
>    a.type encoding info dropped from names
>    b.names replaced by snakecase
> 
>    Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  v1 -> v2: Name of the tool added in the body of explanation,
>            which found this issue
> 
>  v2 -> v3: subject modified to more specific detail

Any specific reason you are not sending this to the maintainer that can
take it?

Also, your changelog needs work, please read the link the bot referred
you to.

thanks,

greg k-h
