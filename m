Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C67DDD95
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjKAIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:09:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ACB98
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:09:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B5C433C8;
        Wed,  1 Nov 2023 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698826164;
        bh=ig3zqGMgh53+mBu+TuaqJ6OObjdIWEMg9RxlNCU5XPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1eVxPEI20y54j3XE5zBMejhF/FUsrZNu2XnKzbWKJfG4U6SZ9Mq2gwfuJ0gEHQZBN
         poues8GfWmSZUnTmeny2I9HJ1gFtOn1MwJba9XinsHLHb8lYPnblkUwQICe2N1r/X1
         cPnuMz6jztf/16Cr/6uF/2hluOX73obX7TJml6eU=
Date:   Wed, 1 Nov 2023 09:09:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Dorine Tipo <dorine.a.tipo@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH] staging: vme: enhance the help paragraphs for clarity
Message-ID: <2023110152-snack-circle-3bf9@gregkh>
References: <20231029180346.8570-1-dorine.a.tipo@gmail.com>
 <ZUIAyQGSfIKqK7AE@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIAyQGSfIKqK7AE@debian.me>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:39:53PM +0700, Bagas Sanjaya wrote:
> [Cc'ing driver contributors found via get_maintainer.pl. Also Cc: Charles from
> linux-doc mailing list as wording patches like this one most likely suit him.]

Please do not, that's the responsibility of the outreachy applicant to
do, as it is documented very well what needs to happen here.

thanks,

greg k-h
