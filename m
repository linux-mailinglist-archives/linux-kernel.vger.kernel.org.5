Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5A7A6B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjISTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjISTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:05:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C06E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:05:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9748BC433C7;
        Tue, 19 Sep 2023 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695150350;
        bh=DCZ2LTe+jIQF+g3pVip0HR5Q7YZxhDE9+8JhxmyYoVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsmyZCU0UpQjZuoDvct3+vpi19wnuVLhRX2yQQeNrRTRcidNPuXbL6Jh2Vsv+7V5Y
         Py8n20q9VF8dqO4D3E4DAa8c376su9gY5VDBUMc8Fu6p78FO6mRS/Bsa6falztIQ+2
         scjPYzIo5z+PdZVPXY9dmYoSpoc+dMh+Vr8zKyZI=
Date:   Tue, 19 Sep 2023 21:05:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix codespell-reported spelling
 mistakes
Message-ID: <2023091949-drove-goatskin-3627@gregkh>
References: <20230917134940.2746-1-bragathemanick0908@gmail.com>
 <CAHZF+VZVBkRP6D4xJEhoqKmr9MbjNFJ8A0NZXSwDEMFJhqBc-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHZF+VZVBkRP6D4xJEhoqKmr9MbjNFJ8A0NZXSwDEMFJhqBc-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:31:48PM +0530, Bragatheswaran Manickavel wrote:
> Gentle reminder !

of what?

> On Sun, 17 Sept 2023 at 19:19, Bragatheswaran Manickavel <
> bragathemanick0908@gmail.com> wrote:

You sent this 2 days ago, for a spelling fix?  Please relax, there is
obviously no rush.

greg k-h
