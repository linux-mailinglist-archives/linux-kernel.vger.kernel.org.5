Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C477A578
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 09:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHMHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 03:51:36 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0951310EA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 00:51:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D7owDC008261;
        Sun, 13 Aug 2023 09:50:58 +0200
Date:   Sun, 13 Aug 2023 09:50:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     20230801155823.206985-1-ghandatmanas@gmail.com, luisbg@kernel.org,
        salah.triki@gmail.com,
        syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Ping
Message-ID: <20230813075058.GA8237@1wt.eu>
References: <301364dc-9709-8c8e-6881-66863cb3d29b@gmail.com>
 <2023081356-grew-passage-e17c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081356-grew-passage-e17c@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 08:25:17AM +0200, Greg KH wrote:
> On Sun, Aug 13, 2023 at 11:48:29AM +0530, Manas Ghandat wrote:
> > Just a friendly ping to the patch :)
> 
> There was no context here at all as to what patch you are responding to :(

I guess it's about this one from the same sender:

   [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget

   https://lore.kernel.org/lkml/20230813055948.12513-1-ghandatmanas@gmail.com/

Willy
