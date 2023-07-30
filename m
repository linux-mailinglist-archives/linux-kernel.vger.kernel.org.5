Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B167685A3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjG3Nfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3Nfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:35:44 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68D198
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:35:43 -0700 (PDT)
User-agent: mu4e 1.10.4; emacs 29.1
From:   Sam James <sam@gentoo.org>
To:     aros@gmx.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        kernel@gentoo.org, mpagano@gentoo.org, gyakovlev@gentoo.org
Subject: Re: Very bad bad firmware loading reporting situation
In-Reply-To: <16a44663-808c-2eb4-ea6e-66f51a66f7cf@gmx.com>
Date:   Sun, 30 Jul 2023 14:33:35 +0100
Organization: Gentoo
Message-ID: <87a5vd34k4.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, we've been applying a patch for this downstream in Gentoo for a little while
now:
* https://gitweb.gentoo.org/proj/linux-patches.git/commit/?id=d3ba9963dbecff37c7b0d46913519cc22bc877c0
* https://gitweb.gentoo.org/proj/linux-patches.git/commit/?id=181caad4a8ad9f6a2ead5b4d596e6e83f123bb05

I think we did send it (or a previous variant) upstream at some point
but I can't find the link right now.
