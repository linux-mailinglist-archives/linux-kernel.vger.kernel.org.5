Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE27F6E23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbjKXI3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:29:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23684D59
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:29:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A2C433C7;
        Fri, 24 Nov 2023 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700814549;
        bh=lKoCrkJ5s5dxIMY878XieGCWR60Uyva4ef9/CtedcUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xxfz4qO7BoftCWr/EbCggvO1QCszKbYNSAT3M4B7RaDIy8zUMZmO21mAiO+s6DYIF
         7xSxsdSngvajNxtlX43Zvkk/jAxWMyTh1CPYe8xPIV7AGLfDCKq5xUjHwysBmWDCvw
         isgXg+sQvU2lawxm9Yoc72ynX5+ox9vQLgqRkudgLG8qAiJBC+4ogqRLjkBgFk0Jnk
         nc7rkZbhoMfHWugNJDRpdKg+J48STOGfQuL0ZZusJ046xiOp5u3z3hg/Bs5E5+qJMM
         OfP4CUWRaH3HwMoRDn8Tb59t+islmjIYABMVBHVOX7gHBFgLk1IOM6djraAmI8I4b1
         VYsvR04tW/uPg==
Date:   Fri, 24 Nov 2023 09:29:05 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/20] [software coproarchaeology] dentry.h: kill a
 mysterious comment
Message-ID: <20231124-nieder-zugverbindung-b0073f12bb13@brauner>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-9-viro@zeniv.linux.org.uk>
 <CAOQ4uxgRiQCG_Q5TP+05_N4V=iFTemzGTd62ePgAgotK52EAAQ@mail.gmail.com>
 <20231124081141.GV38156@ZenIV>
 <20231124082621.GW38156@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124082621.GW38156@ZenIV>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, there's this, covering more than just BK times:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

An absolute life-saver at times this repo for the ones of us who haven't
been around for 20+ years...
