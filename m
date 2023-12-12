Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6780F5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376934AbjLLTCi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 14:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376732AbjLLTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:02:37 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12D91
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:02:44 -0800 (PST)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id A2FFB140AE6;
        Tue, 12 Dec 2023 19:02:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 4D87220010;
        Tue, 12 Dec 2023 19:02:40 +0000 (UTC)
Message-ID: <9f361dcd86507486fb2a1a1540957f4ad4919af0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: exclude gerrit's Change-Id line from commit
 description
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 12 Dec 2023 11:02:39 -0800
In-Reply-To: <CAAj6DX0SpA0jFtKT0Pu02BuXsF5_=UG0N4H8iyB9Rf-gqK50dA@mail.gmail.com>
References: <20230410100255.16755-1-borneo.antonio@gmail.com>
         <CAAj6DX0SpA0jFtKT0Pu02BuXsF5_=UG0N4H8iyB9Rf-gqK50dA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4D87220010
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: iofh7dop1z713pntsi4fz1bii4ebmpm5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19njQIMkFn2TGNJHddX5UlNrgpR+r23h5o=
X-HE-Tag: 1702407760-742551
X-HE-Meta: U2FsdGVkX19ZX/d6y7pkVBUQ/8d42Lg8wLQibJ5Sl6WrVNjaB+gy1+VLL0jbvqJdaOV7HhjC5DdQ8nW5JPMB17w9lbPOT+mmtPCCt0gaD4KN499vM2POq/4WLFjVNZYgwNLWNtyt0+pWfiTy3uEjhGAwDrY/g9p2k3akKvw2YE48dwGs38fgG3PaIsoGvltTBWFwYFYfewkLror/yIT+PnKqMPu707XKm2Ke2oMTZzcrRvjZrajD4WJ2IbLo+cxD3sELKVFhzFkG2AE6wLPx9evPVq85pAVclAuqL/kmpmdzpgTFdsiWxd0AnmJ2MDzDkNX4cH7MG9u4zDZ9Mamjd+uMQxyxmPN7
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 10:53 +0100, Antonio Borneo wrote:
> On Mon, Apr 10, 2023, 12:03 Antonio Borneo <borneo.antonio@gmail.com> wrote:
> > Checkpatch rejects patches that have empty commit description and
> > logs them with:
> >         WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one
> > But if the patch has a gerrit's Change-Id line placed before the
> > line Signed-off-by, then checkpatch considers the Change-Id line
> > as a valid commit description text.
> > 
> > Use the Change-Id tag as a marker of the end of the commit message,
> > thus not counting its line as part of the commit description.
> > 
> > This patch is not relevant for the Linux kernel development process

So don't expect me to pick it up for the linux kernel.

You are of course welcome to branch and include it in
your process.

