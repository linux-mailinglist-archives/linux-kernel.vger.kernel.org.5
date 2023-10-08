Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFDA7BCE54
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbjJHM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 08:29:39 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA834B9;
        Sun,  8 Oct 2023 05:29:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qpSud-0002oP-Lz; Sun, 08 Oct 2023 14:29:35 +0200
Date:   Sun, 8 Oct 2023 14:29:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     chenguohua@jari.cn
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: Clean up errors in nf_conntrack_h323_asn1.h
Message-ID: <20231008122935.GB29696@breakpoint.cc>
References: <33d535ba.863.18ad54575ed.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d535ba.863.18ad54575ed.Coremail.chenguohua@jari.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chenguohua@jari.cn <chenguohua@jari.cn> wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"

Running "checkpatch -f" for all nf related files results
in a myriad of "warnings". I don't think there is a good
reason to "fix" them.

checkpatch is good for new patch submissions, but I
do not think its worth it to adjust all the existing files.

Sorry.
