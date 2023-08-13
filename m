Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6D77A519
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHMGZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D7170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1700761B18
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53F9C433C8;
        Sun, 13 Aug 2023 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691907921;
        bh=2dOStIhvj0hP/8SNzHVd3iSox1StUq7IjUlQ2BWwArk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz4aRbI8xlS0Pse41HXf7xfB1EI0IRhs/C59cGHQVxw2SZTqBPxwtRpylHoeNmx/i
         E7enHEvUsHIjuYQdaTka6IxxKRbNzobUqXqdrVbTTsfBUbOcEs2SJtlwmTbR6sIFPt
         dvXQfSiwdB2afIzzpyx9c9EYp7DM1V+T74tbTZbs=
Date:   Sun, 13 Aug 2023 08:25:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     20230801155823.206985-1-ghandatmanas@gmail.com
Cc:     luisbg@kernel.org, salah.triki@gmail.com,
        syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Ping
Message-ID: <2023081356-grew-passage-e17c@gregkh>
References: <301364dc-9709-8c8e-6881-66863cb3d29b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301364dc-9709-8c8e-6881-66863cb3d29b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:48:29AM +0530, Manas Ghandat wrote:
> Just a friendly ping to the patch :)

There was no context here at all as to what patch you are responding to :(
