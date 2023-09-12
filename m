Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6679D87C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjILSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjILSPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:15:34 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD588115;
        Tue, 12 Sep 2023 11:15:28 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4RlWwC135qz1r1s2;
        Tue, 12 Sep 2023 20:15:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4RlWwB50vFz1qqlS;
        Tue, 12 Sep 2023 20:15:22 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id arhQ5hNygLDL; Tue, 12 Sep 2023 20:15:21 +0200 (CEST)
X-Auth-Info: LN9l6lzYo3wMMEsRLdqLpHZLr7RgI7m9M4Jqn66rlBUyfCIb+Ct3msFl3Xeza20M
Received: from igel.home (aftr-62-216-205-103.dynamic.mnet-online.de [62.216.205.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 12 Sep 2023 20:15:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 78B1B2C128C; Tue, 12 Sep 2023 20:15:21 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <87bkeotin8.fsf@igel.home> (Andreas Schwab's message of "Wed, 30
        Aug 2023 21:49:47 +0200")
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
        <20230819004356.1454718-2-Liam.Howlett@oracle.com>
        <87bkeotin8.fsf@igel.home>
X-Yow:  Hey!!  Let's watch the' ELEVATOR go UP and DOWN at th' HILTON HOTEL!!
Date:   Tue, 12 Sep 2023 20:15:21 +0200
Message-ID: <87edj3b6me.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any news?  This is still broken.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
