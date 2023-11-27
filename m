Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC30C7FA953
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjK0Sye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjK0Syd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:54:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4049D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:54:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594AFC433C7;
        Mon, 27 Nov 2023 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701111279;
        bh=cLlGKEx2J07WGziTxYFZ8eRnv9895QOBQa21gkD0pEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrsbqKOldNWVwmIDvFDlcCLy7xju166Ahrgh+2ivy1ciFjtEx8jGS/u9yj7MXkiua
         Pt2uJc0JbSVl6nomrA/RsrNFPMxBkOK07BnD5Z4+J2e/JY3O3QQfhPV4FlYqLJktJP
         F3+VjXrfqbltOAiBzfVnONWfbmq9DMnoJERSYOG2b8qH1tHpahsKHhAo7F//vEyrrv
         LCui/1fxs+9lL1aAVlR2Nph98gPlQD8B1p+mr2wtBWJbQq6dg/JsPqylrm8RVjTSlY
         nVMe6Ihx/98rC4taDhzMHKli2xv+OD1D6jOyQ+q9vnhzMwOOI4As874CldxMZp3aNz
         a4LpHp9E/vGRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C74DD40094; Mon, 27 Nov 2023 15:54:36 -0300 (-03)
Date:   Mon, 27 Nov 2023 15:54:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Wei Fu <wefu@redhat.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH V4 RESEND] perf vendor events riscv: add T-HEAD C9xx JSON
 file
Message-ID: <ZWTl7KS26Frvwm8+@kernel.org>
References: <IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 22, 2023 at 08:41:06PM +0800, Inochi Amaoto escreveu:
> Add json file of T-HEAD C9xx series events.

<SNIP>
 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks, applied to perf-tools-next.

- Arnaldo

