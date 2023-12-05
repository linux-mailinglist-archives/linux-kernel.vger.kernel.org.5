Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C460B804E17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjLEJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjLEJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:39:54 -0500
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390BD3;
        Tue,  5 Dec 2023 01:39:58 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, kadlec@netfilter.org, pablo@netfilter.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, fw@strlen.de
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:39:57 +0000
Date:   Tue, 5 Dec 2023 09:39:56 +0000
From:   Felix Huettner <felix.huettner@mail.schwarz>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kadlec@netfilter.org,
        fw@strlen.de, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shuah@kernel.org, luca.czesla@mail.schwarz,
        max.lamprecht@mail.schwarz
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZW7v7NIvDxxYI+qv@felix.runs.onstackit.cloud>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZWSNrlHYdp+URAy6@calendula>
 <ZWnD4SqjhHXmtXlR@kernel-bug-kernel-bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWnD4SqjhHXmtXlR@kernel-bug-kernel-bug>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > 
> > Please, extend libnetfilter_conntrack to support for this feature,
> > there is a filter API that can be used for this purpose.
> 
> I will do that and post it here (or in the next version) once i am done.
> 

A patch for this is now on netfilter-devel at [1].

[1]: https://marc.info/?l=netfilter-devel&m=170176886315385&w=2

Thanks
