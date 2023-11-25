Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4597F87CA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjKYC2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8A1998
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:28:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E42BC433C8;
        Sat, 25 Nov 2023 02:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700879325;
        bh=KSXbkpU8Fl5Y02CZ3Rw/HYbRfQgPK/1b+JdCV/e+Nuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IFABNI+HqmwLePnqpI/1FwvCMwo50U9NcZgWATkFx/F7mtJeMwygBYXIyQdLLwek3
         HH8RjMv/ZMCJ7+49ZMWliceqtxTstv6K4jsJ9tZBnWbjUd2+Zn7MoVJVtND138OYOs
         oFu6fYasEGUFBfGAkTIbjkU9DIkPll1hVzljVWfimCbw7tAGmS3/5qoPqFpz4ORG+4
         vPCEUHp2VZUDp9eTbipRiAz+fELvR4x9qq90JtRmxmV+U+E4Wod6d8k8VfpulyA96t
         ttA06iwa1MzCz+PYqhaXUE63+tfRenb/MpGfIHbhXs5P3uC2YzpVzGipLoc8S83ddX
         FdTYbMh3KM8Zg==
Date:   Fri, 24 Nov 2023 18:28:44 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly net report (Nov 2023)
Message-ID: <20231124182844.3d304412@kernel.org>
In-Reply-To: <00000000000029fce7060ad196ad@google.com>
References: <00000000000029fce7060ad196ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 05:12:23 -0800 syzbot wrote:
> <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
>                    https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6

One nit - p9 is not really net.

Thanks again for restarting the reports!
