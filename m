Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF076A007
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGaSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGaSJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD51726
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE8EA6126E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A0FC433C9;
        Mon, 31 Jul 2023 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690826958;
        bh=Eb18bMMUZkKagNn+C4Y50Vy1Cg7bID/NgVClslAn604=;
        h=Date:From:To:Subject:From;
        b=kGUeEmNeMlQm8cde18GWfz871eP9XzNOV1eKzxczNFR2m/8BDMOCdft3OffkNOnQJ
         DEZU2fzWRt4WsX6BVw7uRb5aMSr+tjS3T7WXhJzT1n8qOMJvqgvuwAmowOpb+EMywr
         +G2YQb5LL64+HaOtUEL/PCO1e+GQIwKnJcJDb75xwoxb5MZCv04QM+gdrGB0/o41vK
         4ZwhWnVsdSzqHGFRUdii+kygT7VHfcdRa1MEAF6xI5esaeow584BWGYqAyJAyXvh31
         0IjpKQzH+shPfvvuZSnZx4G2pfQ5ByueMz9mmF9JxdcUDalRDwJj5/obPyJF+Wxntb
         mbTkhz71lN0zA==
Date:   Mon, 31 Jul 2023 11:09:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 17.0.0-rc1 uploaded
Message-ID: <20230731180916.GA2401456@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded a prebuilt version of LLVM 17.0.0-rc1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

As with Linux -rc releases, this is not the final version that will
ship. If you run across any issues, especially ones that were not
present in earlier LLVM releases, please consider reporting them to us
so that we have a chance to investigate and fix them before the final
release.

Cheers,
Nathan
