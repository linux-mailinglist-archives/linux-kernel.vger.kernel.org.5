Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D67FC13B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345643AbjK1ONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbjK1OM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:12:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBAD199A;
        Tue, 28 Nov 2023 06:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dDWm9CUcqa7qH41B7Whj98vA6MVRIJzvGrAmMTqWiVM=; b=k1ccndGcLX6gUrYTrCsxIBOFGl
        MkeYFx0GPSGokeSazUCoUuLws3DX7En3ARF0MB7KShSYyfXYvZDxNFJmI4gEury/xhXb+jdoh0mAI
        Aak9JTHFBKhCHIXnnENMLukO7iYICrx0lKZfV/lbtK1DkNhHM9QM+/xR3iKdGdm9qFqwRwWywrtfk
        wnA9oT/9M75jgLWJH62gKjBSTg4H3XtnO8ehVjKrU8BJNNPccLobTDH5os1FU4rw88AhHtmO1vUqr
        ONBqILc6/puYX3jZJQ9rE29ZKFUtXW+/kZ2AWwaks/K/vbaxupdyeq2khx6QiGTDSUrw5qmGlbW2r
        QRHicwBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7ypZ-00CQUv-0M; Tue, 28 Nov 2023 14:12:53 +0000
Date:   Tue, 28 Nov 2023 14:12:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     attreyee-muk <tintinm2017@gmail.com>, jpoimboe@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, corbet@lwn.net,
        live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Took care of some grammatical mistakes
Message-ID: <ZWX1ZB5p5Vhz7WD2@casper.infradead.org>
References: <20231127155758.33070-1-tintinm2017@gmail.com>
 <202dbdf5-1adf-4ffa-a50d-0424967286ba@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202dbdf5-1adf-4ffa-a50d-0424967286ba@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:41:31AM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 11/27/23 07:57, attreyee-muk wrote:
> > Respected Maintainers, 
> > 
> > I have made some grammatical changes in the livepatch.rst file where I
> > felt that the sentence would have sounded more correct and would have become easy for
> > beginners to understand by reading. 
> > Requesting review of my proposed changes from the mainatiners. 
> > 
> > Thank You
> > Attreyee Mukherjee
> > 
> > Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
> > ---
> >  Documentation/livepatch/livepatch.rst | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
> > index 68e3651e8af9..a2d2317b7d6b 100644
> > --- a/Documentation/livepatch/livepatch.rst
> > +++ b/Documentation/livepatch/livepatch.rst
> > @@ -35,11 +35,11 @@ and livepatching:
> >  
> >  All three approaches need to modify the existing code at runtime. Therefore
> > -they need to be aware of each other and not step over each other's toes.
> > +they need to be aware of each other and not step over each others' toes.
> 
> I've never seen that written like that, so I disagree here. FWIW.

"Step over" is new to me too.  I see "step on" much more often.
As far as placement of the apostrophe,
https://ludwig.guru/s/step+on+each+others+toes
suggests either omitting the apostrophe or placing it after the s,
as attreyee-muk has done is most common.

