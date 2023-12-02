Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9E801C91
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjLBMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:31:06 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0212D;
        Sat,  2 Dec 2023 04:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H0UlL9cUU9+r/u+rnhBZIO7E5lcj+Pco9fQUjVp1II8=;
        t=1701520273; x=1702729873; b=hLiFpoHz1BnyQdwsk4bnsR2IQi94/7vt2HXPSkaUlI8EZkz
        hYGSWieVFK6tNDpcj+LgNyO3dxhqTpYTDPe2ztqh3EqqnX4ls/+ArQN/TGq6dDnRfF3ZFCHDMXxJv
        8BsXkHycCqEMmjzA18v9mthaDpDTxzKldv7XtvxiTM+3LOM1YNzI3WwnVhfgRFcE+taAH0O8faHnt
        sny2Rey5X3+bFw0++UYZNaKjJqhZFPCj74Ou6EO5zMD13Xx99SMyRW73T5MTCW7N0wYk6MFELPcsk
        5nIrsHtU7ZEiooUiSzkRTa1moZzGfmZ6XsHATWlx2jVUwQYeTV2SRrjiXRKzII7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r9P9J-0000000CTbn-340C;
        Sat, 02 Dec 2023 13:31:10 +0100
Date:   Sat, 02 Dec 2023 13:31:07 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Revert_=22debugfs=3A_annotate_de?= =?US-ASCII?Q?bugfs_handlers_vs=2E_removal_with_lockdep=22?=
In-Reply-To: <2023120226-cytoplast-purge-bf13@gregkh>
References: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid> <2023120226-cytoplast-purge-bf13@gregkh>
Message-ID: <67A82FD5-0566-4A3E-9C38-B1EE129FC6CF@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 December 2023 12:33:57 CET, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n=2Eorg> wrote:

>Looks good, want me to take this or are you?

Now I don't have anything dependent on it, so I guess it'd make sense if y=
ou do=2E=20

Thanks!

johannes 
