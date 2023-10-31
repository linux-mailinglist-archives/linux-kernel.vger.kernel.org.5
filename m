Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D67DD641
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJaSpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjJaSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23348E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:44:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E761C433CB;
        Tue, 31 Oct 2023 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698777896;
        bh=9wGTy7Wt84oCiSWMImzHFsPZyAT+ja9sdl/yy3vYpYk=;
        h=Date:From:To:Subject:From;
        b=CrQJTcEFaW/CNKVu5949tBpPErqoJaFBYtv4VihHtBmViSb8yZbIYKYoOj7NHbvmd
         6uBWMil+nWYxzd7pyLvMBLTJSA3/LEr2F+rGN8QzjmSnBifur14Cj1OMQ+fmIFDsp6
         HdRtEflOpnH0LqAUAdw+SKqNpmp+B2IWff/Q3siqrL783YetHPATGWB4CUYzMSi0sE
         8No4d9JrSnNt1oMqoxfZZTul92oc4izfi0Ke6i2olY/rViCwGjiTCuaFJ74ZCoooKs
         aASQMNQo7sS23h1aXbBrrx3YVAIB7OrIrAWLiyBQ2cR0/s//NzcTKSbSz2y8QT9dtY
         uZP4suqLs4OOg==
Date:   Tue, 31 Oct 2023 11:44:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 17.0.4 uploaded
Message-ID: <20231031184454.GA1258100@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 17.0.4 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 17.x
series is no longer supported. 17.0.5 has been tentatively announced as
the final 17.x release, barring serious bugs being discovered.

Cheers,
Nathan
