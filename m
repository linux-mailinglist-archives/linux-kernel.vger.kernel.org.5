Return-Path: <linux-kernel+bounces-11657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A3181E979
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8819C1F2178A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20F1FB4;
	Tue, 26 Dec 2023 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzjuU3/+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638E4C67;
	Tue, 26 Dec 2023 19:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED27C433C8;
	Tue, 26 Dec 2023 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703619794;
	bh=Zu2UK+IAvdYizQpE7NgcsjY4GWe6woTLObomGXX3siI=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=UzjuU3/+5a6sMIErF3hcrI69uV4uplL36x3vs2pmcY0izvbWi53p9pyiPeExVcdUq
	 s6ngodeKMz05GHWuTWSG/4EDRVc830LO2Ncc0Ht739QBbOZAdZZbFwmJV83zRYFoY1
	 y8Wwyz4HUcogacB9J8BGne2QAL2J7hrF2yn6FwnoLuPvPMkRKQUORTQKM50POhoa8O
	 4hOKzjrXSzMHNnIRhIWfMCz0xcNkqIwpVLukjBBEawwLhRUgEWBGIeRceNp9mlVwF+
	 XN6CN5cWLr7hLTCpB0OJHISO4/rjz8kr3FFVjYRH6+9aq310A4ZgUfB0Tfa4Wk3gkf
	 n6tMjEePMCmPA==
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbd5b96b12eso3369738276.2;
        Tue, 26 Dec 2023 11:43:14 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/4Gu5oaa9bLruZrrfcTjWaQUStEQ25wZgpTOajdog9AtxZnZ1
	rwyeXtnqWUXzAs+Wsa6X8q8nB30mt9UF6NZ5KIM=
X-Google-Smtp-Source: AGHT+IEa3LOOqzgEdnVHkMPFZrkw2wjCT2jci9oWmT6hTMFdyCcjvt1PZuy+M0/QBLxqPbGQlPZY2E7afnH++BEhXz8=
X-Received: by 2002:a05:6902:2212:b0:dbe:23c0:bab4 with SMTP id
 dm18-20020a056902221200b00dbe23c0bab4mr882576ybb.31.1703619793161; Tue, 26
 Dec 2023 11:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223141242.676-1-shenghao-ding@ti.com>
In-Reply-To: <20231223141242.676-1-shenghao-ding@ti.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 26 Dec 2023 14:43:01 -0500
X-Gmail-Original-Message-ID: <CA+5PVA6eB5z99OZ-byRyuKdQAa8LXoMKTmif9VH7p4AT8aMYFQ@mail.gmail.com>
Message-ID: <CA+5PVA6eB5z99OZ-byRyuKdQAa8LXoMKTmif9VH7p4AT8aMYFQ@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for different laptops
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-firmware@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com, 
	13916275206@139.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, soyer@irl.hu, peeyush@ti.com, navada@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/104

josh

On Sat, Dec 23, 2023 at 9:13=E2=80=AFAM Shenghao Ding <shenghao-ding@ti.com=
> wrote:
>
> Add tas2781 dsp firmware for different laptops.
>
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> ---
>  WHENCE                      |  65 ++++++++++++++++++++++++++++++++++++
>  ti/tas2781/TAS2XXX387D.bin  | Bin 0 -> 64504 bytes
>  ti/tas2781/TAS2XXX387E.bin  | Bin 0 -> 64732 bytes
>  ti/tas2781/TAS2XXX387F.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX3880.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX3881.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX3882.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX3884.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX3886.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38A5.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38A7.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38A8.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38B8.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38B9.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38BA.bin  | Bin 0 -> 64732 bytes
>  ti/tas2781/TAS2XXX38BB.bin  | Bin 0 -> 64504 bytes
>  ti/tas2781/TAS2XXX38BE.bin  | Bin 0 -> 36248 bytes
>  ti/tas2781/TAS2XXX38BF.bin  | Bin 0 -> 36248 bytes
>  ti/tas2781/TAS2XXX38C3.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38CB.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38CD.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38D3.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38D4.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38D5.bin  | Bin 0 -> 63628 bytes
>  ti/tas2781/TAS2XXX38D6.bin  | Bin 0 -> 63628 bytes
>  ti/tas2781/TAS2XXX38DF.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TAS2XXX38E0.bin  | Bin 0 -> 36628 bytes
>  ti/tas2781/TIAS2781RCA2.bin | Bin 0 -> 1004 bytes
>  ti/tas2781/TIAS2781RCA4.bin | Bin 0 -> 1324 bytes
>  29 files changed, 65 insertions(+)
>  create mode 100644 ti/tas2781/TAS2XXX387D.bin
>  create mode 100644 ti/tas2781/TAS2XXX387E.bin
>  create mode 100644 ti/tas2781/TAS2XXX387F.bin
>  create mode 100644 ti/tas2781/TAS2XXX3880.bin
>  create mode 100644 ti/tas2781/TAS2XXX3881.bin
>  create mode 100644 ti/tas2781/TAS2XXX3882.bin
>  create mode 100644 ti/tas2781/TAS2XXX3884.bin
>  create mode 100644 ti/tas2781/TAS2XXX3886.bin
>  create mode 100644 ti/tas2781/TAS2XXX38A5.bin
>  create mode 100644 ti/tas2781/TAS2XXX38A7.bin
>  create mode 100644 ti/tas2781/TAS2XXX38A8.bin
>  create mode 100644 ti/tas2781/TAS2XXX38B8.bin
>  create mode 100644 ti/tas2781/TAS2XXX38B9.bin
>  create mode 100644 ti/tas2781/TAS2XXX38BA.bin
>  create mode 100644 ti/tas2781/TAS2XXX38BB.bin
>  create mode 100644 ti/tas2781/TAS2XXX38BE.bin
>  create mode 100644 ti/tas2781/TAS2XXX38BF.bin
>  create mode 100644 ti/tas2781/TAS2XXX38C3.bin
>  create mode 100644 ti/tas2781/TAS2XXX38CB.bin
>  create mode 100644 ti/tas2781/TAS2XXX38CD.bin
>  create mode 100644 ti/tas2781/TAS2XXX38D3.bin
>  create mode 100644 ti/tas2781/TAS2XXX38D4.bin
>  create mode 100644 ti/tas2781/TAS2XXX38D5.bin
>  create mode 100644 ti/tas2781/TAS2XXX38D6.bin
>  create mode 100644 ti/tas2781/TAS2XXX38DF.bin
>  create mode 100644 ti/tas2781/TAS2XXX38E0.bin
>  create mode 100644 ti/tas2781/TIAS2781RCA2.bin
>  create mode 100644 ti/tas2781/TIAS2781RCA4.bin
>
> diff --git a/WHENCE b/WHENCE
> index d9f64ce..d84bde1 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -7024,3 +7024,68 @@ Version: v0.1.0
>
>  Licence: Redistributable. See LICENCE.linaro for details
>  Originates from https://git.codelinaro.org/linaro/qcomlt/audioreach-topo=
logy.git
> +
> +------------------------------------------------------------------------=
--
> +
> +Driver: ti-tas2781 - tas2781 firmware
> +File: ti/tas2781/TAS2XXX387D.bin
> +File: ti/tas2781/TAS2XXX387E.bin
> +File: ti/tas2781/TAS2XXX387F.bin
> +File: ti/tas2781/TAS2XXX3880.bin
> +File: ti/tas2781/TAS2XXX3881.bin
> +File: ti/tas2781/TAS2XXX3882.bin
> +File: ti/tas2781/TAS2XXX3884.bin
> +File: ti/tas2781/TAS2XXX3886.bin
> +File: ti/tas2781/TAS2XXX38A5.bin
> +File: ti/tas2781/TAS2XXX38A7.bin
> +File: ti/tas2781/TAS2XXX38A8.bin
> +File: ti/tas2781/TAS2XXX38B8.bin
> +File: ti/tas2781/TAS2XXX38B9.bin
> +File: ti/tas2781/TAS2XXX38BA.bin
> +File: ti/tas2781/TAS2XXX38BB.bin
> +File: ti/tas2781/TAS2XXX38BE.bin
> +File: ti/tas2781/TAS2XXX38BF.bin
> +File: ti/tas2781/TAS2XXX38C3.bin
> +File: ti/tas2781/TAS2XXX38CB.bin
> +File: ti/tas2781/TAS2XXX38CD.bin
> +File: ti/tas2781/TAS2XXX38D3.bin
> +File: ti/tas2781/TAS2XXX38D4.bin
> +File: ti/tas2781/TAS2XXX38D5.bin
> +File: ti/tas2781/TAS2XXX38D6.bin
> +File: ti/tas2781/TAS2XXX38DF.bin
> +File: ti/tas2781/TAS2XXX38E0.bin
> +File: ti/tas2781/TIAS2781RCA2.bin
> +File: ti/tas2781/TIAS2781RCA4.bin
> +Link: TAS2XXX387D.bin -> ti/tas2781/TAS2XXX387D.bin
> +Link: TAS2XXX387E.bin -> ti/tas2781/TAS2XXX387E.bin
> +Link: TAS2XXX387F.bin -> ti/tas2781/TAS2XXX387F.bin
> +Link: TAS2XXX3880.bin -> ti/tas2781/TAS2XXX3880.bin
> +Link: TAS2XXX3881.bin -> ti/tas2781/TAS2XXX3881.bin
> +Link: TAS2XXX3882.bin -> ti/tas2781/TAS2XXX3882.bin
> +Link: TAS2XXX3884.bin -> ti/tas2781/TAS2XXX3884.bin
> +Link: TAS2XXX3886.bin -> ti/tas2781/TAS2XXX3886.bin
> +Link: TAS2XXX38A5.bin -> ti/tas2781/TAS2XXX38A5.bin
> +Link: TAS2XXX38A7.bin -> ti/tas2781/TAS2XXX38A7.bin
> +Link: TAS2XXX38A8.bin -> ti/tas2781/TAS2XXX38A8.bin
> +Link: TAS2XXX38B8.bin -> ti/tas2781/TAS2XXX38B8.bin
> +Link: TAS2XXX38B9.bin -> ti/tas2781/TAS2XXX38B9.bin
> +Link: TAS2XXX38BA.bin -> ti/tas2781/TAS2XXX38BA.bin
> +Link: TAS2XXX38BB.bin -> ti/tas2781/TAS2XXX38BB.bin
> +Link: TAS2XXX38BE.bin -> ti/tas2781/TAS2XXX38BE.bin
> +Link: TAS2XXX38BF.bin -> ti/tas2781/TAS2XXX38BF.bin
> +Link: TAS2XXX38C3.bin -> ti/tas2781/TAS2XXX38C3.bin
> +Link: TAS2XXX38CB.bin -> ti/tas2781/TAS2XXX38CB.bin
> +Link: TAS2XXX38CD.bin -> ti/tas2781/TAS2XXX38CD.bin
> +Link: TAS2XXX38D3.bin -> ti/tas2781/TAS2XXX38D3.bin
> +Link: TAS2XXX38D4.bin -> ti/tas2781/TAS2XXX38D4.bin
> +Link: TAS2XXX38D5.bin -> ti/tas2781/TAS2XXX38D5.bin
> +Link: TAS2XXX38D6.bin -> ti/tas2781/TAS2XXX38D6.bin
> +Link: TAS2XXX38DF.bin -> ti/tas2781/TAS2XXX38DF.bin
> +Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
> +Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
> +Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
> +
> +Licence: Allegedly GPLv2+, but no source visible. Marked:
> +        Copyright (C) 2023 Texas Instruments
> +
> +Found in hex form in kernel source.
> \ No newline at end of file
> diff --git a/ti/tas2781/TAS2XXX387D.bin b/ti/tas2781/TAS2XXX387D.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..3ce40ae9d715727092bffe1e1=
8a6a7e50ea41eed
> GIT binary patch
> literal 64504
> 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
`
> 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
> UH=3DJ(#liDz&i(-dav@5&+2e<m%@Bjb+
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX387E.bin b/ti/tas2781/TAS2XXX387E.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..1b12931b1570b1113883d7f1e=
21654138f66c7ed
> GIT binary patch
> literal 64732
> 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%0A9ieB
> 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
> DkSNTO
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX387F.bin b/ti/tas2781/TAS2XXX387F.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..f8001d1cc7145aae2df594208=
cc30875345cd636
> GIT binary patch
> literal 36628
> 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
^
> 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
=3D
> zdIM3mA92V4XDvjJ!2imOAAtXRR2zNA>52}&vnf8{MY~nZ4M20*vDKpe>4N|JX1kD1
> zZUD=3DxCr5tOvj~=3DdhTzW?GM#ZIkrOm(F7(t)i4Lp4F*G<Gp))y)AnGmJf3e^{2Dw>&
> z3=3DL-zjn5+DvCbuc0A~?ZCp(LnmNZ{Se~nZ(t=3D0R^FAALKEJE<_fc?h_&LkS0MeO+b
> zSwvNpv(Nq<6?Ni%%HPs+x0?B7zaEFWgtO*mzKw1FMX3)ajz}6@^bXEnx_WVr5!<Qe
> zLq7Ll5d1H}<G2|Yxaczplp72}S#$`c7Q%satg{F{k6>UI1n7WT01NO4fRn-iUYH_5
> zfDWhyfWQL5Khtw84qCX!0f{F(U-%_w5=3D1YcOc#Ll8cs|XIIx8Nbrk*2gNxyH0MjtR
> zS`p@R2~rLrJQ{Fr*InkH#r(1U{yo-R=3D6|W+kGZPxI@>t@E3CUR`KgnTKV)#)j{9j1
> z0R1G_!sj{FaD0~JF6OXg{K-CqW!Mlv4KsoWPe3o*HUzc}fo(%z+YpefV@9xT2z<O)
> z+cpHY4S{V#VA~MbHUzc}0ait_Z3t`|f)hQrH$1<yqS!VBwhe)8Ltxtw@LXUz+lIil
> zArQ6%whh54?Fwug0^5ebwjr>7#}~h`^6%sQ066EjZ3t`|0<o#!-|pD)?{fUR5C3Sy
> zzth<^1pFJGZ9@Q6Fn)s;0ZbkIUPDgMwjr=3D>2+q-a4YmzI)3$s63^oM(&I*>Ew&}U#
> zi;-JndQo6&NeMq-i^7%$l%N^7MDoOvYT#N0;e!q)T-4@P*xdGlsRE}VQyTL4x*2(L
> z$hGOk=3DZrjkxIC<JSK=3D4Bej8xwvd^GV>2MN?5xnx)$9gyhHnRVM84fQ-(s(~i8y+CK
> zjdx9`>m+J%H??-qQW>;vqUpfRtR=3Db&h0OJl)CzCdA)AzC&`WH}W;$UxaV_IhNJ(Hr
> z%_iT&67^EDITN=3Dii4>KZdIw9;Ig_Xqw!%i($6101=3DaVz*+`mu7?+~5O_o&4COU64(
> zqJ5q$C;%MeV{ySlLwKZtha$lqrPj7bvG26N`?U6*7WSPMME0E)_MH~?ofh_;7WSPM
> z_MH~?off=3Dfw)V;*%>QhA6x$xfwns6BL-c!4)&Ob1@p+7Wr-ku;qa_^EZ;(+G{!DT9
> zoffaHvhJ^lzPG}{;oM_3*>_r;pF1sDJheL!?<C?B&ss0-J1toMPIae6ZJ)=3DbXgHfY
> zEwsEV#GMu`C7l?UKi_GA@V$NeJ#b&&zya$%3-;|hElzN!#i147AJLzXq}%p;m8*Pz
> zRtmlUY0S;I(_&K3mhKj=3DH7C5&A~W#;y!`vn&+fFy(o5*A>94Eie9yiGI>OeS78Bvl
> z=3D1z;YYx+Oi)SVU=3DKi_dA-)WJo|8CxI=3D1z;>-Swtzk7C=3DSV0f^z@3atNP!_<$k6jW=
b
> zcHwM$6#GsK^KQ;Y_iOU{Z{KNQ-)Ujqb79UG_MH~z>n<rCe;4|l7RTG8biy--VUMyz
> zW^0Vb_9%G<&bCM4dw7JbY<m>grWp1p<I5&bEV*swv~e>^$|jG^ompH`Ha6-TE@N~0
> z_^$KM9XtK<vBK8JoX(;=3DVc@bM7=3D__IQVS?zD{LR}Tt=3DzTKTvtFmyCge#+vq1@dWcJ
> z%}7harBunPuw`OfBI^zp`q|yV_Wi&S>jvm!5<l4)CME`9gJj<ieERaT?f@2NIrja)
> z#{`Fv{cfNAZlC>bpSX|Oezy<vfeO$8)>-Ow{2p;OXQ}r6z-M(ou&20~w_oPI3C{_|
> z#cVjv&jbQ8I1=3DS@fj)?MTL3>fxJc@K1=3DYvLQ@yL2q|{n7{1MV&6fVtyZ&{)%$I;fi
> zm<IQpN<B`n?=3DzoM;t7u_(fd9aw8Mto-uE5*&6=3DNK?e9X^--U?!W<-<UfN1Jl5%zZ>
> zPU~9{DkdxOT?qR(bn$#hK?uYGo`3A$(0_a1g|L4^|Ht?)#QFaX{Z#wDi!r*R-GDRL
> z_YFMNzHj`v(vn-v6T~w*JG5$a;xoj(*h@YPvewv}{&SomF8n?rFm3){%DtPu3(RVM
> zfZ@KJTbj+=3DyuLnk)AyIn+y3N121|78pX~fkoMBzad&yJCOSB)~7&~LRMG5$%@@;~S
> z&s^;@MEe_KP=3DgE89&>N68(7D!?|@m~0OM&~OyxlYEI6IL<X=3DAND@8-JJ!aH5%%Z<z
> z#(a2OS|GkJc9!25Q&FZ4;Ik|av#+47l=3D<GPO??9@0W?haYkp(wZt!Lvja^f7(l7eP
> zSbUqQ7vwj_xLv>TZ;VObE=3DW_lwQ!tgd(4yXC53%Ke^$ryahCYq3HE;%?pfj~_A_U^
> zkGas#5>Fv7d;f>C9Q%D7`+XeqJGJNJ8?)zn|M$+_i=3D=3D2coBiKeypN+|QPTnT{tw@n
> p{jHxRHnIQvt-X&U_J4z(DEJ56|6Pos67A0EnW9-Rp72iY{vUHB=3DE48~
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX3880.bin b/ti/tas2781/TAS2XXX3880.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..6cb9c9eed180dd7fbae5bc16b=
f299f93cb3a80e0
> GIT binary patch
> literal 36628
> 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
r
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX3881.bin b/ti/tas2781/TAS2XXX3881.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..51f74f92e9a9bf13fbcb9ba5b=
1126762f5e872af
> GIT binary patch
> literal 36628
> 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
> PF;vX%lAbAs&(r-s@sBoF
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX3882.bin b/ti/tas2781/TAS2XXX3882.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..51f74f92e9a9bf13fbcb9ba5b=
1126762f5e872af
> GIT binary patch
> literal 36628
> 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
> PF;vX%lAbAs&(r-s@sBoF
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX3884.bin b/ti/tas2781/TAS2XXX3884.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e29dd5a474f55d3896fc52c8=
aa006a192a27914
> GIT binary patch
> literal 36628
> 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
o
> z6w@BXv_~=3DTw7A+GAb1APCG$=3DT^G=3DJ3rGu`;p5&6dF|ITJzr`M<>V(GTofhaQPZ03<
> zzuKJ^AFb>v1;dTpY4POyyTqLqO;4s01M}xQEfAg_?>eOYuzap@p9TBoofen5(;}iy
> ztFx!-e<gR^Imgn=3Dmtz^$>NEX)U)*V-zLRa;>u6hkr^Wi1y~;Q08cX!%F4jp)`cu2E
> z_u)1QAKBKN6Y}RfEiAR-EPapsS?XTpxC-@Prv`x+;hT1+MQGCMO7FDjxcPv%(_;IH
> z#lM_8Elz%7-f3anD<R(b=3DldGk0Pwqwd8dVWrv)@Yf0vwnwzt7=3DdFGuKkV7qid8Y-h
> z|K^<*=3DA9OS_hm39*qL`)+^V~zc>Mj^@3gqk9wh}k6Wt!=3DDQr<LwMS{M<4k)LzK2K1
> z%CtvOC}58=3DIA_eTk;5mAA2e}f&X|GelZK4U85r~pmw{<5on2j12Tn*EC~ST7*(~_K
> zusGh}2}0rFi>gBrf5auqvk{Ji{(;Jd`_aOnpy2`gsYrtPl%}Ue<5H>^RoF7IEs=3D4D
> z3te(|uz5eQc|WjFHRCR@%I;M*?+1P_SKRL_B&GlRNoSzEmYVki8&Wjy2R82q=3DDVlG
> z-NEMlz!m4IUW|~Nc9v@14}2r{1KWlS;q6yo--PFcAw$@39J?$X>T)E=3Dr2~Bu@!9}>
> za<G!r;`ekuGLp_)w~!Q98VK)4I*h`lDe$>Krd2MWJ#S?i+;b`wUuNGIcut8VJf;Ni
> z`(V%x8+LQwXMPtV@Er~4LN1x#g)qMhaVx$HVg80Le#9_;Ll@r_`DK3>!u$>WKjga*
> zxBNHstL^)4!`>{|wZlH`TK9b&ueR?SJScnQgMkyo>pD9$YIONC#60XJp9EP=3D>^E=3D8
> z8KO}o_Kh>98^ZBk2KR#nyDOFJdF(rfd;H7~^X!|xbx*E#g5lA$2dX@>b^ZDL`@g&E
> zksV7<GF)qUVlO4WX<L!wO8hIRD%y`97lf<q8)KEx2jc|)fIa2~ctozZ9>MvIyjPQ#
> zv6sAVxdkyZcm<)ZSa+6}@f|V2-~7f{u;_lh_L#qwZ;TzPlfpV~d<X1?zcJ>n(nAV{
> z8?nc{fp3hdXp<MfXIUI(U-`J-MoKzzpt5g3IY7g7Kj$~brrox@J@dHORW>L6q;HHx
> z)*AP#{Kgo!>lglwG3lFG2}-M3PuyaA%q#CDg?&L=3DR>xa$me~I?`@f&<EHQYTRW`=3D1
> z8)xqS%HPKcmMw>`Tb4lu7<tY8U%hzad$Pgbku`8)|7m_>_SSr3_P27Dc(eC^-hXVD
> zg5gH?e>d<xj*9uk3o!S8_{Qun{VcJv{ogO_eH^j>YyIlt|Iq#4&w8eaVaU#ZHTN&z
> CzQ!E@
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX3886.bin b/ti/tas2781/TAS2XXX3886.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..27373152eae0fe45692556181=
0060ce11f7e4c61
> GIT binary patch
> literal 36628
> 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
q<1
> zuG203gXfkk`<Bb-za@NWZsuSAcgDej?{kkWKFYZ1qlf=3D3U{paPF8|laOYp~jQ<QZT
> za=3DTvg68y2>yjr<ktGou}^!)OLS+CtJ_+!7x@!k_!zrU`ueqAHYANSCi7PGaRn;v61
> zO)c6HHaqa6?0~?Ukp>ufjX3)TZtCHQiCV;CpRsS`HE@DI_M84`6!vmW0}Og2&VD(r
> zR<~!k-wpRmpR+HY{cIagmBM-O|J0X_+MVt=3DC5IgGCopM_m8$-<fT}kO8S=3D=3DH9>n=3D=
s
> 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
> Gocn*NjohsO
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38A5.bin b/ti/tas2781/TAS2XXX38A5.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..3eb0ead64bd16eaf8838818fc=
53682e20d2ea7af
> GIT binary patch
> literal 36628
> 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
> NJyXOmWaqn*`#*aP_yqs}
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38A7.bin b/ti/tas2781/TAS2XXX38A7.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..81b0ae57c2ca09e6327298d0b=
d6d879c164eeb70
> GIT binary patch
> literal 36628
> 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
yO^
> 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
> E1IXd+djJ3c
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38A8.bin b/ti/tas2781/TAS2XXX38A8.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..b5abe6005205d4684e489165c=
116e67ae5a0632e
> GIT binary patch
> literal 36628
> zcmeHQ30zgx)?eq`!{q`OMIi(yE~JDwM2cf(2QtN>7oso6myk1(IEP|#vExk(p{#tN
> z4f;xZ4O%@*&7rQ^Kn`CH4MtgfR-cubrq7|Dz<vL<&pmJ@oYMSWbvD1n-h1t}_u6~y
> zwTH9My8E<m-@YwTQCR1fZ$C~_Uy>w(lW4^2eL@Cz?3B>@j$3cJy><Voqb85a9zMN&
> zo5bO5+a=3DtPkjPXQ;etSe5=3DXsK3$08P)*UdQmb9}_1Ex(FH(`w9w(OCk&ca`8L?VmD
> zOUu3_Jt5^1Ik*kINT&1x$wpMEHluQ2sz60J)f@K>dvTSjQccVGn1+1=3DYQ$xlSRjWm
> zAOC6^A~}I%xf38FK;)I(Atb95C8t<Y<y5(XJT0adk>^B#M=3DI4)Bt`43SmhLj;7hWb
> zddej<P}`=3D++7^ZLCCVvekyFV*p7;>KN2Z(ti;c7t#VYckT=3D*6_j+V*0C=3D+EkP=3D-a=
@
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38B8.bin b/ti/tas2781/TAS2XXX38B8.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..454db9f8deb8b3984d611189c=
2ecf514bb0d7e01
> GIT binary patch
> literal 36628
> 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
> Ee>nrji~s-t
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38B9.bin b/ti/tas2781/TAS2XXX38B9.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..2760e31055b1b57656eeba142=
5c719532cb71d60
> GIT binary patch
> literal 36628
> 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
&
> z-!=3DaE<7f69FKm6x=3D`6})i(J|ijKc69sTmXzDKU61qg3c0!XE4;W1yh1ru|er!F)<H
> z(vol~RkA8<nb?-dy2FKjc6YFSKXAml0lHq|Cp*K$#2}n~Kk(_x%en(toaNZ}1J?@<
> zA^Y7v``teK-9B+2wf$}%<^vU=3D1J2c1s(nB3S=3D|rpDJ<mem$`4kb3$Pu8;<icfq-@#
> ziE`OMA40q}fS(*(B=3DxzRYUAUn)>TPTYPA{u5a}=3Dqm*&B@EYX$YXlq?egL_V;9VgiL
> zna?TlgvXTVeIE?kVZ(0k`|5wQ=3D4V*@yAbwwA)>w+(daiI8v9m+{auLD`c{OB$x3_|
> z!u}1NAI^z_QNZ(${Tupk@4FE8Z|MIV--S5;zoDOM-*+(&@hCU&4EBA4PqpuxIH9=3Dc
> z7V`x0jLr_N3W*7*(KAHcy&dxq$Xa4=3D`mb?@xcIw-z>I}|E%k2sHZZ5@_YC)D-P~ls
> z){V8H8^7zZVCNHu7%b7Tf3ovGafWpv?<G$mFVTK{W9*FO7A4@5%C`|ZK6ACt5bbY_
> zK@BcUd(8d4uVWpzz5`}`1B|C}F_i}qu;6s|l7IcUpA-$z_Lx!MFpK_<8S~+BX@U5@
> z*javKOhuVGfX}ix%)WxQQpUTlH1-Xs1kf<uulbF!yTF@yG<1#4Nx$eDWAUw~Uy$Dz
> z<97YVzcD6#vnWmJ+RSmD?J-ZjmlXB|16Uo;$5|r2x6<hT@4`JxJjH(IjQ24Y`dQ*B
> z<Yn*waF%1gk7K`&V}7UhoP1;UT<`zhzH5mT4QI3eJB#;mR4i&bz~2Ai8?(Rlv&2UB
> jf4{Z&am4;_$jZEb(*57X7%I{3oSrF~1>*_t<nI3gg=3Dpr<
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38BA.bin b/ti/tas2781/TAS2XXX38BA.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..509e98a59d685cc56e16ce4f0=
65ecbea647690de
> GIT binary patch
> literal 64732
> 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
-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
> Mc7Ed&x~fC}29U5!wg3PC
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38BB.bin b/ti/tas2781/TAS2XXX38BB.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..d729b9771f31a9652f9e00963=
94109fc869c4405
> GIT binary patch
> literal 64504
> zcmeHQ34ByV(y#aC$mAqIfCK_e2to{?0m3C9FP!1fF9Zb?lyHcE0pt{7U?wn(C=3Dm}9
> zF(3*qvWlXpD=3DLRO1lNs-iYRh<pzJOR9*80!N#^@k&%EIU2S^~WBHh1VP4}zr*VSEJ
> z-CfgN-LF-vRxOB59?x#>xtEmgq$mWZ(1<#bPxfomHl<nf)U=3D+N&C=3D4kG`o9j^JWvK
> z3?0#IYV(w9nm22a(xPQb%N8w~_3PKXWwW8#caIv{n%^zsBJqSAmwi_T>w8d%nyvu6
> z9VG6GK;1ND+~{$4+HV*?;*RsGuR>L-_+PZZSCm(kYDD!kgu9bUvH6OPs8nl6#lQq0
> z!xvU5C0}Wac(uu?I8KMx18IXit8{n18qM$ZGp18hNLAYcVnfCIswbLMjq0oEW~Z8A
> z>PX(Jr#?j9U-P||+OBlP?CNE<s_E)Z_=3D@VG9%>N{aBVTGu0k`vm#U_dNzEWTd6T0B
> z9hIi#n{4DtH(SL!$QQmzO`_%MHX4IG?8w99+HNM~p(2kq$fKH?5&kIhHM^3{7UZ>-
> z^HMeSu&XoDB!y(*9j1S`y3JyrUxGZhBuqvgCgh>0TKJ=3DCMu>)Y@e=3D5p!B20Kts)N(
> zQNEW}TkTa(@wbtd&2jTf!XI^8XpPI75bl1LUUq*(FS*m`MdTgf+MW>V>YQM6Z>F{6
> zZCc-#myPChraW7*J=3D#X#TRPprcxs?c7ku*2a6#XK`WKq5^q4k7#FuJrA3e&<_o{1L
> zo76S#q6F2wEy0vus-W(af%2Z1U#$Gd@$*Y4&gD_68`4~bG@1T1sIR3qdDRJ`Ouq2b
> zBJ2TmuD=3D!Z-=3D+Eyp^a=3DP;~U`dc-LmCPu}>kzISLo@ZeE=3Dsy~lHJljFzVe-~(CU8Z=
{
> zdevjm&?cm6VVl%+g&-ex<~QD3;D7H6H63!~ZF)#NXJHIs`XM&(#^Q8uqJ=3D~cs}E%n
> z_;EEr2_>&)X4wTFojPC9K5Nmo3fc&9D3_0?yCE~th}(cTIxTJ|r*Unf)`)-IYL7nk
> z9@Dp>{kv<sMVas}m1?`W9XTKP8@LT!%fPD56r;B#c&_>ArhSNfJK2iO)6f>n)VnBF
> zMZH|EaB{htkUB7YotmNUg!Cvb57%ilAzu&p*M@PT{-NN1Q7E~#a6I^z9$v^YO5SD(
> zOoQc7uM_AB*`h{i;lSC@ZlK-p&3te85?7XDLfS%g66B#To?Vfojv_PYsIH=3D($Uj{0
> z%A7?JLLRvva{a?lf5F2v7xHW)%D{aD{g}L#`5cEjndg^SBHW&<707M~*Ae~dq<bLB
> z+{<i3|Bq06Q>?p4F}X7o)tzREU|FD&Mj~(IJHVGO`gA(R1@vF?QZGS2+(+M)VGa@b
> zyhmZKfo7ZAqlCEA6$|pSx(5ywyb)#TLUHW7HRV+P82((DEPIywk$*k%Mx=3D|hkY&(*
> zgXIuo1NULH2epPwP5{r=3D3Hsm$(!Ay8J;%>Sd>f8Od61uy{!ohdB<hKD$`p}TCU~GB
> zuXIZx`aq<h<*|IB7O908%R*3hh4Y(VoM00C;<Opm3T-OVavFX|(2oRt5g&ep`HHf%
> zQj5@swuOJq@*`wt*JyI>K^u0)__a$}@7jYgQVTD{m}UkoF}{L-R+Rfo&^&>5S0G30
> zR82*nV%ci~{-OO#(;g9J_47;6k7D|#@y#Fat3TBRKQl4*925C^Fdw9wOHjWMb)Y4N
> zWg|Ln8M%vwa$Rli^q~s3y*p#5>ef*1Tg{<@<{*j{b@t0dzSsPlpkD>_QC^qFjFF%z
> zw{r;hQSitHIS8d;X^$}te?QxW_PtfK1>{p5j{cTGsd!e=3D{$`dlwJ3a#D^1J~V!Vf(
> zVk|Oa{4gJNxgf8;{yH7>oq|3_XXF$2Pzq(Ef8EV#L_Ia?BzRZU8-1q<&FP7G5AzC@
> zYU?8G@sN4y#LpZCUG5{`xtYjZiaH>VboBEK8UUvIo-sd(K1EOBIh1*B2mPD!tAc(J
> z`n4a=3Dyi+wA16g_9*jD9jBQBrdvr3amjle)fbjJ(%*E&wFjd7ZLe&;xrodlF{KfHZ4
> z9h__>`cGDxx^?ST9k1yDzhCy<I%JN(@D-XBNaYEHRI0f-dOzxwMVQx9okXm}IJ{o3
> zp2Qf|fMf_b4?=3DOT(C*?rRCCjIg2dvvpn$>DYaDrRkD`$OY-21%*G2QF6ho$Lemv}l
> zeblmLOGY4W8ewiX_3E45Y>az+Do`<iCWw!QA6`(fIBe_I_ces6mSq!um1}k%TF%g*
> zPtwL|pB6ubOa^vu`pVbsoJ5>Q?(H|Kwl-sLy8iw5-f)zb^zh)N($W=3DwhevAnzyI4-
> zea=3Dv>pQt0#$J`!1bS{{1jo?=3D{=3DvfLDQy;-=3D#mVnYFL<@NrCpDe8p4?`_OdYa`lk0=
b
> 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
> W=3Dh-K9<I7GrzNj|LejU|&F8BWe^)Oig
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38BE.bin b/ti/tas2781/TAS2XXX38BE.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..b424d4836884f92343683c32c=
604a654270634a4
> GIT binary patch
> literal 36248
> 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
=3DtE
> z7C!SlIdEQ`Y@R2Z=3DgH=3DIGN1XI=3DgH=3DIGS-UxZe^Y)o9D?=3D75K;h4jPDG3um4uU*=
)_$
> zNQ#DB&GTgQJXzKC!aPsreHHUO**s4+&yz2ldz<IUW!`-XK4Uh|lZ|so^E?^vFXnl2
> z;9S=3D{PsY-!D!@EX#(n(+w|Smyo+q2<$rulCrY`TS@Ys-#Im0|pzS?;*+g#wPQ0>@6
> za)yeUke3zr;V9}y97*$;GevoHTorPJk*edWyLB9{;|y<&ONxk5UF3B()A0#p-}1&Q
> zdR|=3D9fk8CU-MA{zVG~S7_>K>FsPt1bdPwr<!anXP4Z+>c2QiYR#}bW5!tI=3DSxS7cN
> zmZ;-6syvfwT4=3DFAUfkiC0^GEtMAJbe+eu1wSaPA55~t@^?g8HK<k@*w#@B$Q8!pn7
> zZAT>QWsT=3DT+@ff*s#KN@k<4d{rcB)b)Wc3L!ZJxFTingJ2V&coTWJTx{o}W_k?nKD
> zp|{`|9|i;PKsZ&$LxFH7;V7AR64>@p2-UQ4hux%kC&6dlNigpuU|KY6=3D*>F`WZp?I
> z?<AOa5^#l>?^^5YDAUIMR<3PznVUB5rj2_M-e+czY2$9%xMNKC&D*$#?Tdwpt7+rz
> zMrRvPo;wNlnQw_8xFH+&qQ!@$jeFfS8Zj_`wsA*z_9x3K&OKl|X4tp0Z`!zD!N&c5
> z@6TsH8SPTmDQztW7ag&j$U3Fpxq^-Rpckv#&wc5+qK*4q@57eyHtjMSckARxI<=3Dut
> zg?g}4gTROI&9ZT?eY#*_SvKzV2A>S+_How3)%JE@^=3Dq<mC)o5~(Z>B?$Ev1{yJ_Q&
> z$3s7B(d~oTHW-^8hTXY5i(y;`fWRrG8~z2mHvOyy_PeHyy9&X;$?bL1#$D=3DAp<f<S
> zCJ3`$F{l7`jORGcj@XyB-w5*gl625Fi8pQBgTEcf>kiY#-L!Fs0lQ(}ZrZs2o8N@-
> z4>bBvWZJj~#Bq6m$KvwYxL<rHp%GRM7|(Gh;VF=3D~{7ym_9e2^41kQ!b=3DA8sc;dgl_
> zVZ?;-qsES&HhI|8u@lCpB~Hs2J0UITyZ&hjZJoW6veTv{q{;gpmustBacpu2CE!J!
> zDnkL!;j<Vk5v~OtLoNqCG!qJ43-jNdi6mT|@#tyM_<lw;mH0jj-zN#lU~*WeT=3Dv~l
> z^V_D{_1ji)7n$ESWtGyMVRvT4**9>eEt+YIrs|4e+M<<b-`D)MDSt~>ehc-|@12_8
> zHZ{L(YVP~~YW95{85z7Z^{*-M?v#-c%_BYUi!t2Jksy}{^bd&F2Jm~5os>51sU$Lz
> zO6*%ni8<;I??XB+O)FXOnIPx2UX-`Q&UvaJY4a7<#Qt};NW!aI@S3=3Dbxh96>;EeSd
> z-Ve<0{hQzWH^29PE57${-i43{C*;NeWI%b=3D#6kBU_)dg*7b5VV6C3_xYhv>*#4Y>Y
> zzj+tp^8c&(m42V$T5IBZ82N%-C#+%1yC&{-tu^t8VVPrx`*)tNYtPxJ(Utd}r(m7^
> zI<nQqTKtymJsVYGKd@E}LS8qH=3DNbI3R<OGo4fmtpMY$%=3D*`FJ+<%H|uN~aj+CJe1G
> zt6*b^xBqv|XYE|^14DV~-IR4Um|bb_`C9dm{Bh^_YHhw2jjNTtmb@f?th29MZb6m0
> z8vmedfi_x!H2ynF@;CoiON!|?f9Lr3^1oVxx}0PkH~#zThW}Tq^K<J&5R`YF&CjI)
> zH{*Y`RJ6$l;JdFJX5YT^%U#qu?as39ghn9`=3Dldo9S1T)_Ry^|v{!c9qmo+At|Eq=3DD
> zmcOC@)xzI&)wLX+{=3DK>P{9m&7%sa+(FP_$0vImVde3@(GUu+MW8)mq&#-HoPnQLQd
> zk9Xa2GdcnO)ykS{<FzZx`p-TCC)eiYf6m^T|D653>_Ok;wXt&O`^<}=3Doc}q?<AMQ!
> zwebzu<Ea>Hd;oK8jQ^Z9_n`mdd(gZ#w%&X9Xmf4+U$-`{hhZex-PFBkKVgi1S9kvp
> DGIoO=3D
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38BF.bin b/ti/tas2781/TAS2XXX38BF.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..906bd03b6e99737e0d6fa6cd6=
ea2c02132a4a2eb
> GIT binary patch
> literal 36248
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38C3.bin b/ti/tas2781/TAS2XXX38C3.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca4c0f6dde186d184fdfbbc4d=
ff037e22654262b
> GIT binary patch
> literal 36628
> zcmeHQ3w%_?)j#*{&1Un$B}5G2wFwww0F4md2se?(2C!WM<slRTgm)x71VTV|gEw1>
> zF{r2|&<Yf!*otVChd^`#wgSQ@4{b3@jr#fNR|F{*gpVZq{m<OJVTs{YkXpTy-^t9J
> zIWuSG%$diXdv<R7_U+peEs2SHGyE=3D+29qQaoJ83ja#MzN?vyfWSf5cTsrR%UHTxb;
> zxK<Z|3@CBjOLb(FiDG&J2Gx;v5o*w^sgtHoaNM7pJ?<j>)kY+;SOT=3D{OVY2UW<-uu
> zgfmE{tRl%qRIRq8N?>Y0Mc5UH2ZsZ=3DYE`*F%lVjweFJL6Wtvtb+nG=3D31sWnbg=3DD!C
> zAT~_om3?-SRcbCfEiTz5SCRkD*-OZOy2vk;Yfeeg`YKl0sStcg_E8^sHx1GDDzdgy
> z;e4sGlPt1}9OO^73qCUC6<KVgITfqOgL2_p<Rn@xAE3!7!+|m^+98y=3DQ;|_dN0bpQ
> zyCR-Mxr&yogrKa=3DT$bz%XTCD>Op^~-PRhGOvyjh%e3Gn2JgL_?R7E}_f2(~p{1qD^
> z4;A@ogVj<0f}9i8$wmH%C%t><Wp5O{<UL3my#we)t)3L2?Uf=3DqzjjCp(=3DsL7k|YX6
> zJtZZperr)K%Q-=3DviTYT957FLM9`o*^&E#+0T-4QPqr!A5K>y|yh1kee>9E@fvUSop
> zkv~E8Aa5w@H5T;`rDs%4;H%Zg*e|Z4%p$+iP%Bd!dUwam-UIQLqG}0pq3&qgx#CLc
> zD^3SpBh4o@2%@<iG_C-RB=3D}p=3DepM<bzdT*kO%MN8gncAyd#HJ2SfUMe+Y0$_(RNXD
> z@;7-<r=3D?=3DxA<rhMdR%!2aR+!jPX4BC0=3DT!x??~6nQ+%?jyoJ8_LUt)z1^-a=3DKlFq=
A
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38CB.bin b/ti/tas2781/TAS2XXX38CB.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..f548e39ea0a80ad61fcbab93e=
d92d501a8a1d2ec
> GIT binary patch
> literal 36628
> zcmeHQ349bq)_>j8nM{%i3?v&8&Iw`+0W?B5BB&jfV>om}KslA5AXg-SfZ?18Hd)jV
> z1Uv}*R^UU>^%Fc+4mo53x<-zb;}an+8bv--P!K;3e}tLu|Ei~x0m6N(M^}C?RrTss
> zy{cEQj;?uK-Mo48rbIKNo9|h0lBB*QNdza+z`c7LjZbZr+$6cxohgjEIv0U#C~?qR
> zm1LKRqT2y_RFZZUs>j$7Lq`mD-j_Xa&{_D)jYwp%1Zdfpq#~(^$jQy>L^5UOOEw~(
> z+JMS{DF+qd^gui~9KiWhrGl38F%A0$oD-L6WWMZRKA{yfL~=3D68aw|Y=3Dn8+)89VDw%
> zPj*?-<#hQB`5TU#N&e&ceyK!rNs884vC1xm;7hWXI?Bb=3DQ`@Y_+D3)*rN}O_$m!%H
> zf09G+ktrwNVk6C^SVbO`3*RCq(js{~4MQ1Dlwr|!qRfqoj51oHjOucF#B7wSXh}*4
> z%38@~$*yqbD<jWHdAsGPTpXH-d=3D})BWHn;8UguC1`H1|DwwCi(Y=3Dk_N@26!}XSE7B
> zC#b{n{SmYCKBl+xBI&KX9rR{iH(IV$ks`FslAZHwJEbr!L$b|Gq)^mTQZlPG7Ui;>
> z>#I+oK33pEv@ObvyiK%{{Eh30x_WIitu5uEe{=3DFfY-B5QI&1{lx@eHdUtjegZz$^Z
> zDC!?dFRGfr`_vii7o4Gte7_Q-6)7=3D!#qo09_IOLaPl8<N9<=3DS3f->m{r-Lp|^GZ=3Dc
> zG`E5#JwPJ~{#LYKl}gAjj}mp$!~Z41UXrzssh&M7!G^l6hWuA)o2VZ7Yd@~jQUUOg
> zXYCX{u6%;H6Fi<Hf1M@)+(+bhw$;m1yt1l%gueJzPFGe7{-Nl9=3Dm+`h6*5h}Kb#;>
> zZa;KLTFYs&8eSy3LI^rn3SM)Vj&(*aQ^>tS-|MTp1YWfy7n}*P<+Y8M<zn=3D|N^|oz
> z$6FAGT&3H{r~X^;x7jFflX3zwI9)+c8K7Un^s+ax9p_=3D1e7|Ma%tU_~_bd6;a2{9a
> zM~~63(4m#+GYNVWTpu6w*@3imNTajTxc|d2zU!-HTxYF_W`J&$)#<3n-$C_>_8>3n
> z>|;IRa^SCH9nu!cByXZ<Lx;4zbT`ve{kDBkmTD^-m?OI)*2u#tR?Z|z(;`^ky^uc!
> z4fuzHKNUz?aTsZv8;ZUF{YD-$<ZlwsWucs9=3DhZzSEeZH~sPo;nGG%qanTYvXX1oPD
> zw^4qAVzq9FYfVTVLSR%NYu-*MyHQ{sA)DePyWk%I{fF+0I_veeqRb3inQb-7&B5H_
> zksn3fF|R<coJ^-_sB2r+3$9~G0pn!oChEAF$2+H?K5IZf1Nt%w<9H2^Wge%RHy->(
> z>ioF<cC?@QCZuJeU!e`@#BvJYdP7ckv;2gNyeuC~%a~@#mo`{dEqlPXj!5^{OVaCM
> z*(1_GgS5Kk`TZgKm=3DSo(9xWpv|458K7qub3-6isSk+0Z77-!j-tHPl7Hk7vq@$PxO
> zl@obh=3Dx{p5d>VAy6)%agb0$Hw0qyUpj~C3HF3i7}C&^Epxm?T#Cxm|Yk|dN7ny1D?
> zfM|ae=3Dzn^=3D6=3Dj8-RaPeE{UIc=3DE@<fr7Jvc;va`)x2>BN`g066XN|H8!x}z;&vRB?=
%
> za7MXX(^y8_R|>{`y#+HfK@S>EL;c>bNT&k9zbfSKuicXAFfLtku{2hcxf%V4a!_x`
> zAM;AOWf$g@NYVF0sXOCQuTa+K^0}Z_#4+wW*^Bw2SXwJ@kN8^j+aBmk$xxc<^q+!m
> zNb(-a$J(H`A2ToH%<F`#l>ntiY(#y&)MbWw0BexqwA*d54ql7M)-E9#b7D67BLljg
> zjde<bzIL}~+B;!9bVu1XyVIV@{RW*YL|V4u3>wdmq>a|~Bx0v%e>L<!bPR2<p>8(t
> z<1r&)ERog=3DIP^RE;Cp!s*`c4%2gpN>SfebCT&R@{C-iK%)(3RGlrUv!q|@Oj@@PAU
> z6L4W#3Hpi4D1nUjq{TA5wmmJGX|+9_zzF?c9qnfxUd;7O$9a)YP7iUAuWc>N*Qd~S
> zvMCs@f%dchbNg9`S$BCHl<P020gt(I57Jr#pMkaMq|hbs;PSX^v^7ldj{^S;B^>QK
> zj=3DodCGX;HNbHpvAyy5{CZgZY%fW+%|UittzPaVo_!`zGN_oZ0&DWLzFm&b2o)JZwc
> zWeA=3Dq)0*i}Am1>wJDeVAE9Nwww*>!aUVjy?YftckzN1Y%-=3DtFt;xg){KsJ4_hLmV&
> zV&B2Kg82o@XSxMzDR{BY>+|4vv^yR7<7OsP7W88zr-^!~;3wwUF3`6|G_4cXQI`Lo
> z(Er#wkWc;6?yPOoc0?3Hk9e#IJmj1W{BY<iuff@nPnN7w26Xaa^h>6#owd5Q3w^Nz
> zbeZ<1+IGc;eMk=3D>7naQ<Z3jU|onl<LBqGI!@rgRQ2)#jL@?%*4s3#^g9gk&=3DWk7b0
> zql;ADOQEjxvWRm(fd4S84XZ>S1o~Udg~9XK1@wU1De4B^B-=3D?P?7-j1zr%fcWwb}>
> zbl80|D-kH+e*B;zeLu!ZbRaWL-nw<Gfme+{z&|^0EmG_)iNZ3=3Dsl4SOnPN6M_M_dI
> zgneg<hbRPTZol7ekOYTSAQ{S?7ooU!Xm42w#T4x%et@93!a@d1=3DMm(8xC(_H*v?pT
> z)VUWONYP};;^@%;lv1;1%@~2S98zp#>D(=3D=3D$*{a^-tb2Q8X?^QKccX3Uij9n+f;<9
> zMo1C<OSkVmw1}a8*TnTXyUP}!kX{`czw>pfhltCV^zi+%t>xoA?%B3wwcB^5qZgTc
> zzE|FbM{<XEzp+J48^G-oZDjsfS|SEahY)TT^2!3gkivP?RmfWMaK7<{|F|<Gwc}D1
> z;f&>-Ll`=3DL+hse$pX=3DW@pP_ZXzdXj!?8R<(GBnzrQO3|9yvIijwc9;7n*l{^08{~R
> z`?CmpPj(&;k=3DIL9S_(lyQm0N~IfL%{d{`O+Jp&RbENB2MOppjQ0tuElfCu0Olmb9-
> zE`Wr2cBN1UJvo1!+9r2m)#_!X%DOqPXC0iid`pKf)*b@|#wa-fb<5`F4LJS&h&z0T
> z+vfRRZ5w;RJTm5>&`e~(7#4teog%m_JuVX_7(1uy&v`QDI2(G}*>?r%GlXohoJQe`
> zGImhArcoGqLg(1`{Pg}jcjQBLa=3D&_ap}R`jV+^^C4%BcDp3pis>FXNYkCT`8x@Gp4
> z$;%#he$svMxVm#k-(BmcVO>9bQk(L6^u*i;4o^?rGGy|nuFm6+9=3D;F!atQm)sJi>t
> z91O2z+fer{JC_mV-PSeN_Qi`+PR0+*JzV`s_w(IOPI1ql<(a0gbWa#GFgI-50{4Us
> zof$j_*4*cg`!p<f^PG<En(hC=3D!1XsAm&f6yhtsO|j(Y#66&;`5KI){rw^z}q2LylY
> zH{Z_9ZFv8bDWAQ0=3DfAp-`LS-dzNJxp_7{9Jy-t^mfBtRJvTwMIzQs{Xa<d-z*OUV@
> zzso(k@Cf534<Gze$gr7>x%{h<m*9{6rYP$Q<aWK}CHP~%d8Kl@R(bWC(Eanp)84pM
> z@W+0W<2|29{czox26c_JVBC|ZT1?k&ZF-dDG_hoxV|wVvIU%7nV+=3D6z8gcdw+{8m;
> zlC<b&ce8KgHE@DI_M5?J<ao8F0S3JhXTKa*tIJ&Ocf<YC>-4LqcW>dTQaCUEpZL7-
> zJty0bpFqxppD}5Ul&bzXkE%C|82Hy8x)JAR{pbB=3Dkh`jKt}s7Mzjp^!O<E=3DRW53Du
> zQBj672oNlHQuqD0`Su;(#r}jNBa)t8KWfe8;#8D^<!ByNJNSJR))HP!83*SV{ITB*
> zILoj;`!>I@q<#zbhfF>0eRbZL-j(4-3>f*s)8j_G$oequ=3D~=3D^Oy*zWc^x3!J1{isb
> zIQs@}+`a}SPuKrEfqlUr`%R;a;4}kA-RF!l;9@wQ9~mq^AAFpB_jmU^&(JBWXc+@f
> zwqnBdAYcIZKlYm<9<$*w3WgQWBoRQGyS4jSaPpZ{qwL`FgLyC?mW=3D_}9ApW2?x-xK
> z^zTSbPJJVQ`D4Gy;mHk~EYyw{B~x$9J_9EHw=3DMs#?Y|u7MR^89EuFN8!|Y2>RnI1S
> z>>RiMhk1-+=3DU@Bq|6#pZ%>zLNGzjl`D4;7lgY@S;4h#8XzX{zsFYR)0Qzrc|%L^Xo
> zI&Sy5IH~K2yZq{#ZP*{uB7WWLegF2e;E(+#(?8oYy$$<gpQ@7jT+$l9(8~B3N2t-?
> z`?>$;!B@!A;on5v_p@&w*XMy#B~8DOpLwHLe)V*$ykgZR&P$Z)4t>z^nf2K28e*)6
> zA6oy*+T1P5ccJfDVor6mj(KVyxwdOWb#_x2&X-vJHNZ*!u(uK)F+>_s_cb+8arO=3DH
> zBFyrZ>&$mEpX%5bRR_)vpI36;r?I@ns!kHtBk2`DDaqA3ah}Ov56nd}Dd>wjG4{U`
> zw=3D2BgO2I!?v^49Ml;wA{|1>r|X7}O;DQ;~X)BFFo-9h&+Q$F?B_vNdMkk?x2@rVgT
> z&wgU~TrWa9DROBZS$B=3D5yLL?w@sP1)tiJ+6>aHfK<8oAZ8@)T>D=3DsQgl!x}mar=3DYn
> z8PHX(E0eIROuwkG<94ZA`wvj3NH5bY{tJ2fy)AtA;#TuL?=3D^3Zfwj~Ccju7txkHcT
> zu>91d-cz|;v_Fw*+UQ<-rH+V`0?&eewD_i!E$N!;d-I<>cXgXow5re4@$*36gBpwF
> z9$Rgk*^%@<k!=3DAovA%6W4`e|1vHu9i2G)u$vSI&*=3DaP#$8L4>2XI*H*ePKyPe73+5
> zt!D%PYYpS*Pk>ZFJwOit@98)UC(;?$27p2>pTKVo2sn|B`YAC$r0DdPB?$LHSf2}T
> zXZ}pba=3D-%?@pIU@aXf43=3D}0qpGx;?-?u$E^|7AKE?X1-<m>6e5#Qg|)LH9}WE_@B=3D
> z9J&l3k5C*igk~bnGO7h&DdkXY8>u3qPtSOcd0D0V#oErg!k{PX|Mlk_J?so51bprb
> z;oSZfTa7S$DKhVQHv_`?0NI0oqFm-*N3_}KXXvcOh2+)9Rsx?N2N}xChU}*ydOCoI
> z$BuQz(n=3D3=3DIw39@!nEpm(LR(TGoH({iuTtv$jbSQ3Zmy=3DfWMR*z;m1(m&@gR0AL+u
> zV8=3DKH6~K=3D191qZkstB{ggFD(^ube;ni0MLyiqwFT2|9rn`Wp#-#M!6NJB%&SmjQCa
> z<L4b_37yvYa=3DB4~RMrnCfcsyZw~$ltuYq_rpc<e6a0kGP>@@+U2!mc!uLH_<Ar2Yf
> ztc7S6{BHyCqwrrqwb6H+u6W@$3WyJQ(QXxU1JGP{c#&v-yx_kr&@QA?D1hbFoFg~%
> zEP~}<U-0J&1)P2+k>b&79<2YtVHMO2<<5)Hm7GNowG{2YMey&3+$=3Dwa@-vBZ&mtl#
> z&LRpgb`~)@da4)w)k|H!%9}bh(|w_{2*JMr_8%8GlQ`!rV(a;55ru^zt&XIqs5JLe
> z`ljZ))P#d=3DnjUZLOPrAK0k-{B<DQA?8Qm%KL!7@f!Fs(lJgH;{pL;L}{<q?BJP;SS
> z;4=3Dx7>+wKYybww$gahdqXAyiJ!NAS~@B&H!EWlF$PP)`tgy5fGD?gh+7It$1Q5QU4
> zxSBHwqBl^c6~KB8C#DM=3DSVI496aCMFi(v(TX_#P@2=3DloFDaR4+3%I`PF7r=3Dh{#bwi
> z6YDPXZz%X<t~z&}JvV*>)?JxglqBR28C<sGep(4YKgp%=3Dc}~?GpCyG3<gldw$xei2
> z>40<qKLC0V9)w;tZ3s*o0@H@Tv>_nbiy6VRA#n0yZQ2l+HUy>(foVfv+7OsF1XvZx
> zv>`BU2>c!#EPDZ^06f^A3s4h&YBp^MOdA4mo_r;?7p4t?X+v<9ErOU#^naIQgJ9Ya
> zm^K8a4S{JxAkOej8v@gYz_cOY#gl)xBGZO|OdA5zhG2h+$Fw0ZZ3wQ@dkv-yLFKl4
> ze*_x>erE+sYhrwwr+%1R6MIgDtz8{I!xVun4alMCxG1uPld9utc;JH$CR|kO5u(~H
> zV5-1r$W#w`oVV+FQpmb~*=3Du^9R$Ly|@YeW6uFYDQy6n?wR5}rjVg#>t?8BC&Um?*$
> zxkPv|k{)%zv;lP-%;$0Nhf(#3RMSE)%AgG;dIGqyr9@AnkO@wbYTyk!WRntgdWlWh
> z0!~;?v}b%QDGoN&tn@uBQ7<K#GjWTeNl|&<u>cv*dIw9;g+x;pY=3D!l(le2gbPN$H>
> z>;FC#ze990-=3Dh-mFU7JPSY~*aDG>?~2#32kq~pVT>3ArTG+ml*+M}3vTHt+J^G*x%
> zP75OQP7Cu+3-eA3^G*x%P7Cu+3-eA3v1L}p|B8R6J&I|MV%npacUoNP4iG$p=3Da6})
> zg?Xn%#nM5SV^4D4-56Jx|36}nQgw1u^G*wNlqU#y{9o!$i<0rhQZQW8ofe~##hn(-
> zjwKTV^XEG)5T0DuwO9Lj$xP!u3---BEiQ1UMMRy{Q^y;AD|gsB!_vc-ZFwy9EB$?6
> z+-aeHm}TARxTpM1i#0Jjl|$-EOZ0}$*0BrwQrj*M;HD2B*;bww^5;7(EVbe+y}y1*
> zy06L+73#rG4FWI1*X>S=3D(1aD0-f7Wc!)|e>#pa_6emi$s9Q(q&)55q{LcH_O_cgQu
> z;CCDIP7Cu+3uuD=3DE;;*bZ-d|R%sVY0hgtyhP77ZD%{wj3J1qk5%V12fGw-yxS$9eC
> z`1`%zX;ER1Le4Nb2|E+r9%T-;DCgUww9|1n+#UsYwmsxA?NQFT-}hH;kMd~th{uKw
> z9y@x#n4#Gt`tw(0`Uic&rGH8*XBXFm{!gUz7p6X9E<5|5usB|eelK@;_@e4kO}@J-
> z40bLQ2mJ$;4fmskK|#X<_EV7r^C?YFi^io?F{;oVwk0y|aG~?=3D4mR%xHtz=3D(ie}se
> zR@uGE=3DKa7Q=3DZO1#g{1U<S9J!;YpHoZupveBeqi%{V7_}=3D+#PJ*4_tAc>ct4TZfB|H
> z{lM39Kd^1!K;C`@_Dy(B7&wp($Fa-Op*}}~T$(go8jg5v06#fcNosi)or#R3Gu9%K
> z;z|SIPm$hUS|_c8&jm8Aau)3wE7L?tF3EL)eP7@?C6e%%61?w&K|5^N&3&KwU5LPU
> zG@uJPWPTUI{4T`J_%4L`8#+Ino4=3Dv!-xc|7e;3014gFX0U5K0h8~Ua8eYfxs4{~j<
> zVBgo_Qv1F~2V@O>ByfUwWrv4>8eQlNF+obeUh+9m)x>`Drko)L$w>c3LNEeh<J>72
> zeNi0mWpF=3DOu)7$&=3Djk6E?$J{}%eAln!9A|pQHG~d9<DNJ<C-&h5B_-Pq%Dh%F<fqW
> zVlO4WX<L!wV*D$pD%y%47lf<q8)KEx2jc|)fIa3}ctozW9>MvIyqA)fv6sAJxdkyZ
> zcm<&@T6dP0@f|V2-~7f{u;_lj_LzT^Z;b72aX;(0@g1;h{>Ippn75>0xF&ndtN+HB
> ziZ*!xe3r#w_7$|15<Y&XvTr~+K*Mx5@*86l!P^TS=3Deo+~q^tVISY)kHzsqloal3xw
> z-x!k)O{=3DG*PJ8wy+hbmQFDdK`?qPMj@n?yNd_hH}`@b7@mKZ$FDjQ>0j5GIt<?rJJ
> z%a+4eEX$w*jJ)RluR&eod$Pgbku`8)|7m_>_U3$J_K$Lwc)j<38$NhR3WjUi|6Tq2
> uI4b5BFTmXY;TyBR^|Qpv_J6;z_i@Djuk~9Cex>`r8+xXQVaU#ZDfj=3DmZPShb
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38CD.bin b/ti/tas2781/TAS2XXX38CD.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..28f707ebb8fd9553d20bc7cb2=
4e7882b66232cc5
> GIT binary patch
> literal 36628
> zcmeHQ349bq)_>j8nM{%i1QJ8Sl}W@H!ePX431Wxk2#0P6tei@?L?9B7!w`^}U^9Zo
> zL_k;rD)4!&tKi8YhYsKou1^jRh@w&SLj?q7Is6Ej{lDtzWPoslYgg^c@1?3<y{cFB
> z>ebOTudACkZ{CckAYxVc@F67iCrKhWiH7d}X6~ext&*A~wYoW(QJ3aIkPRgcd%cqE
> zGEqbaK(9*DPDAyYFnYx3;f_19h7LOof3XpXEEXRv`;yc~YD47UW_2N%GV&xFQJLC+
> zN`WZ{72z~r+&}EYm8nVvE$3qz_6;~AF4LGiIgI%PR?ra1NhHgy08v3Auj~mUS)~{`
> z)siNs$*0KMaAE;@kLG!$Vl7otw62O(PE`oLBzvf{TtvOKO^U3oS2$m?oJtlsjU41n
> z3=3D@20%FeUcNJ~|$A`i-iZ;=3DydvAm5&q6`PhuxL9_=3D6Xd&87)ypO*t)OHp*4BL?r-a
> zE$6c2)L`Z-BhMIlo8_=3Dv6qtd07UYv;HDtD4=3DRg(th`f!ql=3DD|?gglhzr6pEJjS4x(
> zt0VKgA+y~Z=3D?!-%z3$#luep2BQmvX4qHU7woL}1^1!?J$tssE{QBO(9sL@!I%W{rW
> z$Duw}-~+VH%H!@0w4A(+V?<p&Hk#g^a?!upc>y-El{&&~1lgw2Fp)n_bs=3Dvc>NN!Q
> z52SgjCh%qI<Lu|3qVznk5~;0IBHcx?vU^*sC9h0^T&Nw|_FI0bbcoYI7p-}ua6g(G
> zK$GU9kpzD$+OJB*<dw&Yy6NHn5n&I>+D3}82gTb^x0R6p3T*?$khkvrIxXb`4|&#2
> z*5k^@h&#aJ3G&u!;=3D_GJUPpVqJjElc%17vnALKM;rQjck{)c{$H>Qwj^1Q(Wd2;)q
> zL(*zalhxpLa%uoU=3DSsk94%4yD=3Dw%AISLl13x>Mj)OH%%+0GqpgtSlFy|5bX*y(!j$
> zIOHnbNM-7mg1^m1?hVQ@$lzoJJ*9*G1*Vrh2^}~O)8u(AI|~xLrQEONRfBn4p&wmF
> zze0zWqt7Jhk$-*4pwD4QTZ1$@Esgs>2;)0WE#*3E>*#UNt*|=3D6D)M(y%S3yS7j-UU
> zJ>qiUuVEe17Re-Upa?^UwB2+Y(^Fjg{wPbel@868Q$tqCqbN$wAW73gSl>O6KL!o>
> z2ZKN5OIlG7X`32~z5xAt9y8=3D^63b<woF!+~Jw7E7_!!jrHe0E(GXGS_0xcuf0-akg
> zkE1B92jW^2lJ6rh%9k}y7nI$|H;<4_agbf`4}tze_eGucdRtLux~<f<66I!NZgI&&
> zP<PBL&?^ViX&UO<p7nz37?9668M=3Du&uH^B~X{gUC&_51+8H;heipMgKQ_T|#eq(fg
> z+<rUS&wS%kGSIKkhBRV1`EY$9r`uS5LPj2z52j^Ivs9KcTvjc+z_*@A_r@gZ^|0&`
> zX`n$`{qp?Y0Da5|yk(b`?vsBg#$PJ6C9geI<o6(7k%chMvM^T#LGNuSZx`Y{-F=3Dl~
> zZVz-g4P!n9x}6#;iLrAkUbF%2@2!s)%$=3D#2e=3D$#zm%4Jfm=3DBH#{q7@4C?n9V#zKH-
> ze>LcTTC5di1)Nq^2Il?yNMc>k(iAKJ`3hubD_8{i7d3*eaDPgYHi&wnEkUwJUY~zT
> zxlPkpM%-5l#(m7ff(+1uhSN~LcPr8<U+}LE`FrcOWIBw?RJll+Aj;f?endH_H{_3b
> zCC#!Eb4sY_`w`TW@u*iI>vQ>B&?n?q?mO9o`JzZ#EpH3?R`lC0=3Du7bkDsXsDKsO|L
> z7v*7X(A$rh7jouxLe`3bQbX3GK40rH!#sdBNO9Qhwx}>(i^$d?J_&PT7WyL{x}Jq~
> zN`k)jv}f46U_A6h**3ewp27VFohw9Img4Xm&x2DQ(Dfu_hiHEd^gnbAZLpzkHt^#y
> zBVjC&)(1HBJNn=3D!c{ACepU?-$Lk(G_JQuo1D;`DY*<h_7=3D=3Dvx@%8Q|nu&{M5ZO14A
> zE=3DVgzKXDnwkkPJ`D5lr8r6e(}wyO&mq5o^5{mjFIxt{4bFY?K00bx|uz7FQ=3D6KFfx
> z6bx5i`&s|F{j9^RyF3oc^_SCt$6UD!X>EW{$J%sU=3Dn{Bvd0aNy8YK9KgMYdbjCLJG
> z-zngkjJ~jiMK2<E(I5-A*_}E_;&t1dHb{1>Be-ptdr|%V6vaOI^k4Jv_-%|jDMz^s
> z!4qX#Gr|<eHwf(xrorvSoW}E(;2**3uflch4PMZ9w29}NG)hKXM%@(1rXSXjVl74N
> zJ6KmRzhL=3DHvtTU+FV=3DZ|9-M@Bry+lIK@w#`KgMvHsD}!EVxH{=3DeQQM1yI>t<`Co_r
> z$KHX;)UWN1x;AZlNFnry$BMv1&RM{Zg1+(^oCW!0$||KpC+|VOWY{`bYic{u7u!LX
> zVQ;2wQ*79W^b&Gm*$i$!3_9u%<04feQpzwsQKwWwZ_xO>NY+2<jR{T1V_9Pvke%b`
> zB9-@2s4G1y;@l75KN4%h3eg9?{uXng|2%dMJ>YhVx`8*zc2WsD@K^J0a-Lis;ZnLB
> za30T007|%@-)~4ijkgkgpOGSO*|NpJt46@*pPsi4DfX5`K^f&#p7M}PksHGHqTLyU
> zeP^<ZC;(|ruh(mk_=3Di;>8Oogpq3AbhcWE(2uG>NU0721(g$$Oiqse<uH46NG8)GS~
> z-tFi>iXclSM-Tg;gl@Uz7DgZ~n-m*ay7tIyGSZ#J8~zADBczAH4=3DF61AG~GDRuy5Y
> z6|fHfrKY?0FJ_4Ap0GCiv(kkqq)(^DZ+_d_MZ{%Hx#v#V*7E*d?Y3@S=3D`1_d*@H}F
> zWzWA2kK|5oe`gDyK8V{V+Q|H|w1f<r0U<OM^2!9ifWrCIUC3H;alT1~Z`~Zwy7P-F
> z!s$!91~7E}q1!fwzr@|KfT7KRzuwDm%e)>pGc?+kUdqrQxYtJvbvxWOn*l|<2dD<%
> z_Gc3Ip6pyMB9Ditqy&P3q)wc`at7TkE5p*@>lu(hVL=3D06VS+@c5lFDa0bBqNpacMd
> zGXW&bvpWTb(Sr-tsBLp6SFc%GqO6(o&&++ZmTvC!)#_hCfiX%BK>gCE+=3DEWOJNl-w
> z1MS^qFSU<4XC4`IP+$hKU<?buyiOrpmL8W06O5hH_2)bpbDRx5?dZP@^|_C1QJhA>
> zi_^DLhi2gzc|zydcm4A2d}rw0^>V*?dy%tR%DoJ^jlQqt9G=3DrAH}TtA+>Z|}?Q?y>
> zD?jfW)2l}G(`DJ8OqjRYdH=3D}GuS{>z@vWSVtL~Wjal$iGKK*I^q<#k$fnPRZzZqVC
> z@2Y*lb!_j|f8EYygnPDj&$WFuZ|d>bk+}zIKInY1$MLDo1+!e!)#c8dVMB9+wk~w$
> zyw{b%_5G?loY9{K<!+kO*;%{eTMS%(!*O{We*Vj*z4~9j{ngj!Zg^w-{6z`<K7Kl0
> z@W+1h?e5i<cYEuXuFIc&w(hv34omO4xn7IC`QOc`*Dd|SXBIE{j?3s@6#hbP=3DHLEz
> z>h}dd<{n;jh;a{%8vgfykp+#p{7aFS;E(;LD60x`yHfHJ{ITDxs@yJDUITJ^e(~J&
> zS8ovfvESr)?{Td^SaYgDeIv~u_uz>ZGqf9;9cDRAF5Vh8BXDDOKw#}i1B|>zoP7f~
> zdH?uCE#k4y*f;VTIKdzLP5(3sd#Sbo2E7qyzZ_Sm+f&@{hWoA0$(K%kwwb3&;XL?%
> z?2E?jj(41tLyq_(m^8;o)qkE(HE#(S`pCf^#Q9nOdB5rBE~%U<=3DBF9AZ>Q>sD+GV+
> zH@QA4%5eArg5^%?x%bAhJx6!4pL1w*;>@*US6wVlMJZU0(C);8;aE#}F=3DZT_SMbMv
> z)8{NB`|a5@_l39??B6%-sOP2m<NH>I8$D>u+?f+c&trX<ICIv>S<e=3DXl0N?-*Z?E1
> z5oh1PP2AI<cxK!e@$3u!*l!wT_@@~->N#hu0q4W<{K#NAvhRNOoj<mFlA%lHx+M%e
> z*@_9*g@6Iv|JZMec;tKcl0PhaG?4((?A6OogX533Hp=3D!d-=3D7EbVc8gf%|WJsg2DeU
> zB@gUOjWoLe=3D8yd*haVdL$S2ygl7`gRvd4hQuh{Y)>G<_T56Uwj{KYAYIn2KFaLp{T
> zN6m4156)*CJMZdy{)P2sB@YA@&>*<?exI)F@YA1nI4tCk{U&tlth9^4O`URZmIpk}
> zblmPUaZ>kVw|dpr+OmINi`X^)?ElOW!5{lgrhlw=3DT3hxfJY22y6N#(5LMvk*KSYgQ
> z9^m}suII_p=3D}V%Xd)c?oc=3D_8C2ajh-M^?vKK6rAhWq0HaoR_GzGqBUdTGrw%--)pv
> zynpR)t8+IiKL);Ii9FHSI{x83)bbF{Q?DORK{#Jx`PTv``GdZeMqalR-ENKQt2p}x
> zco1fJ%k>sGnNLmZi)sRAhtDfH@6%Y`VpS&z>yh+4poHWaT{zD}-ww@1GAZbby4C-(
> zpSWGY1C|T^QKF@p4W<tHFlAHiBiFq=3DIg+ARM>D<m|2ph*{x<bfmwiv3$_RP2mF^G8
> zA$sg%!{>St+DV}=3Dy2-lp0lIZ(j)(_LC}sT>5Kw<5Nu8IX!dvO>oNu_O1W_K^AI<Ie
> ztEW#_xvosYt}^|i!p_^IyPqD0I)!?e=3DDEL;Yrq@AcRtr@f$N>-%`vcEG{D(4U{dag
> zU$a?$YGU7MTrS$5K(%djJ3U`d#ED0)1^s9#n_Bup_uR7AKIFNp$CPy|`c0cOAN0Mb
> zu~_c0)s}7qyh~(Th)k?+8_)yk(0%Mbg0X?MqKj<Uzu~#$yiP_cp7B{1ns8rOk`SLQ
> za71ev0l-?rIJyqd8W02M1>ij$hv7sz<JtmHsO4k$&^5z}bkt9Y1SVOhx4eLGKZNzU
> zuqpFrI+g<-u!x_-&Wz((OHW6d!JEl1({W$i#QZPP$!KSt4*tYA6C&<M$P2npl4sFB
> zaL%F20P+aL0YhL0;w+;&0G3iV)wPi-BKq`<=3Da^?zx>Ky}tSbz9vi@Ix&e6jTUxLr)
> zz7WpoZL!4&!<RzcPdXV8&I8CU{1fFe|9Ya$Mn6MmEvZOeiEPF2`Eih;yllvRI-)0i
> zczEnsXDqGsFsBpZk|9j1ju-7iIWpt9JgaDbeS@r=3D&saZt4*K{@xjsC{*>SmC&ieq?
> zQ3iI5V^9I?7|(GZeV~dkJ3P3f{W0bI(ML=3DdI6|cQluXbGywKlJ=3Dp)WPh2CLoiN5ra
> z8y-LJFiYsP&X>y#_ocFaH~`%L;=3DF|%f`2W<vj8;!`GA`M9%Qc#C_xzXqI#WBb}HhK
> z0nS>8X2Ji#7e5StE~<^b<8;LXzmZRTz>9XPm>YoRvV+%&_QwkTTYc?9It2n)Ud=3Dgj
> zRnH<=3D{&9joSIFn|Gl^uEUUPr__YbR}W+-<agsO5DLDW*T|9ZiH0CKbZ7|PEi&OD0<
> ztvHJ)Jl|Qw0}<0a=3D&wHN+7+JG(=3DwdrI*Sne8({x&jx&if&LXy)eHKwz7|`lavWiM`
> zKc#JGzEh3g*S6Ww#$^dP@$X~XUp@NK@ZJ$!GCsihOB1ZuTY?jdxAVCNgW!Jy9>;xg
> zf%89;K)Eg#l*I#~lt4I;j&T;j=3DMfC-TmTQC1i%730pO$yoka-#@wW1_31ngS6d?SZ
> z=3DL?r|CPDNn%CrJlui?aWfdfnE-;JXGd2lf-127E}tPo*7mmuXR!u<hPcHL$E3Cths
> z?|)+5W&RBXf6P^9uCr&xufn=3D3Qz|72`9lU5?YN(o1JF-$34ESYb;oB(fkQbg>3^~V
> zVOeS^wZspAE`+gPGi?ZPer?(im^K9KOdA5s2&N5zgBNSlhQPETFl`7-8v@gYz_cO2
> zsz{~{foVhFb>U#y11JID!TwBun($MzX+vPz5Qy{Ss@PtbHUy>(!D+S#VlvVHU5pKa
> zX+vPz5STUurVW8O!#8aROdA5zhJY7O{@sd98v-(I2uvG-y~!@qhQPETxI*tWm^K8J
> z+wT1tYzX+B6)dd@u_@#Tl51nnsj#(c*b$f_u%!WoX*w>PY{8`JxLPjwpo0k))fr4w
> zw*^cUI1QO%kjK$f&y!5nwM+h?=3DV`^|VGVDCU*y`ZhN;UQokpc&5hzCR>cBp1Sq8vH
> z_HN8@crlWOq{6fTbsWy;aqve{&B;{TLi1$M1`>?}ZbAvsgD51&K~gQeVTWu|f=3D(~7
> zDVxs;%ZZMRk0K?E4K*u$4@=3DZbN#ac0q6kt{-ghiS#?#)x5_AC(lnGm5J?!8tE`-x4
> zAmPftPsQ&LUCZ~V#QRH8EC-eu-epRF0{FtgsT|Vr!F_Z*6iM<*u<11IQSct7d8dVW
> zr-gZ^g?Xoid8dVWr-gZ^g?Xoid8dVWr-j%utKxsfKhqw?v_~=3DRQOr9nE_4S7p24%p
> zywk$G)1qSOpo_65IqPnWD(3%>*rQZCG}pY-0v+Y@10Meuy3^u-GfMJ@%em8Ho?8=3Dl
> zS|n}#lo*&l-)VvHLm5%8YE%B+)40!qee+I>bKGf>)Mwg>($_ziN+vH<67TJ!-2Tgh
> z`uo1P)8f``Z&`~D#g^Y`u_|(hvR_?piFmK8b;6?l)FQJXQQ`)&Ek7yb&v#l_>O{+)
> z_ExFJ$iJyj4|b{_co4o)cUsiTs579lJ1yeAIIw{4w1`|XeZ%kOPK!H^Og8VdFz%HQ
> z@BH(94Q&DV-NwAr!o1T0nxMZ+&OY1Q;I};UP7BDP4#2$Ag4ciZP7Cu+3*Y-P7!&Nw
> zJ1wr&T~a*${^)mFoNkYjh@FXUk1_{al(X$oI_Nml9)<7W5wbGvQ55poqYTL!eea0j
> z6CM~eeni&jf&3MjfqtKG8JOJ4(JeJ+;J9W3g{hA|nVt4uSRAi*`Qh;JMKz^jzCSEz
> z2Ex(MKTz3lKUxqJG}vc96-qFl()6?lTuK$G3R@<&B{J@Cp|kD|Htz>E?*|sDX50l<
> z*}cl<{lFWu#r?iQQu@D3Is@gk)Vv?qkfM1%uz5c)-#snv4mR%xt~gKiV1!($vsCkb
> z;LExn*fw-1Z@+x|COjt$9m<B|*k$Pu#}Pl5B8`$pAzl~2PYza+THZ>hLPP14bsb63
> zCBE>dNbe}Ek=3DDTH0-07hjrNq4X~Lz$5}tf3-S_#PQ$h)kDgOID7_`HN-Q4$?--Ymf
> zM+3T$P3CtY%<n>6i|<01zoCmCG0fl4#dk%1-`|BWe?$N8_%6h?{|)^@`@ZY3H}iMx
> ztFZ6ubfJCUkU^Ov2K!DBt9E$ktJ1m75bu=3Dk#9s0VP}RnM^O~F?`U}Z8W4bIH?`3d5
> zn7=3Dz;xvrT%hdCdZ_Ia*-?Lp_n8iyGkPQItwl=3DZ7lx$pY<<|&&O|H^Q&<%zwN_@-?|
> zj`Q)apz?hq0to!LAY5hN81p3wud;Flf1f?3KP`tVqpvFNLh>^9l2w+QUuCOWCzhA-
> z9WlY*{KlA{H0h6PkNIc$#@Ox_ce0Kf-vPVqZ;WLJER+1<a_liL;~Qft+T;Q7Sr&)c
> zSI}09-}q)_-+&4O4bxrCZ;VX_Zx48!=3D_;F(F6kR%p>@XoA-^%k?fRX6V@%pVJw_Q6
> z+2R`8W1fF6DeMc{u{vJ;v&3Z*zP(cE{_m=3DtCHjxE%EnlgapwN7{CymM*>bqbvh*v!
> z$ZPKZ8q_zwC+q(mSpz5bpXN7augy1R|14*TS9<@qePh1l50|t5yNvg7RLn0PfVuy}
> mH)enDXNi^U|9)@p<B0uV)35&ZU%LOhs%MHAhU~l-a{mSqE#|8L
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38D3.bin b/ti/tas2781/TAS2XXX38D3.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca4c0f6dde186d184fdfbbc4d=
ff037e22654262b
> GIT binary patch
> literal 36628
> zcmeHQ3w%_?)j#*{&1Un$B}5G2wFwww0F4md2se?(2C!WM<slRTgm)x71VTV|gEw1>
> zF{r2|&<Yf!*otVChd^`#wgSQ@4{b3@jr#fNR|F{*gpVZq{m<OJVTs{YkXpTy-^t9J
> zIWuSG%$diXdv<R7_U+peEs2SHGyE=3D+29qQaoJ83ja#MzN?vyfWSf5cTsrR%UHTxb;
> zxK<Z|3@CBjOLb(FiDG&J2Gx;v5o*w^sgtHoaNM7pJ?<j>)kY+;SOT=3D{OVY2UW<-uu
> zgfmE{tRl%qRIRq8N?>Y0Mc5UH2ZsZ=3DYE`*F%lVjweFJL6Wtvtb+nG=3D31sWnbg=3DD!C
> zAT~_om3?-SRcbCfEiTz5SCRkD*-OZOy2vk;Yfeeg`YKl0sStcg_E8^sHx1GDDzdgy
> z;e4sGlPt1}9OO^73qCUC6<KVgITfqOgL2_p<Rn@xAE3!7!+|m^+98y=3DQ;|_dN0bpQ
> zyCR-Mxr&yogrKa=3DT$bz%XTCD>Op^~-PRhGOvyjh%e3Gn2JgL_?R7E}_f2(~p{1qD^
> z4;A@ogVj<0f}9i8$wmH%C%t><Wp5O{<UL3my#we)t)3L2?Uf=3DqzjjCp(=3DsL7k|YX6
> zJtZZperr)K%Q-=3DviTYT957FLM9`o*^&E#+0T-4QPqr!A5K>y|yh1kee>9E@fvUSop
> zkv~E8Aa5w@H5T;`rDs%4;H%Zg*e|Z4%p$+iP%Bd!dUwam-UIQLqG}0pq3&qgx#CLc
> zD^3SpBh4o@2%@<iG_C-RB=3D}p=3DepM<bzdT*kO%MN8gncAyd#HJ2SfUMe+Y0$_(RNXD
> z@;7-<r=3D?=3DxA<rhMdR%!2aR+!jPX4BC0=3DT!x??~6nQ+%?jyoJ8_LUt)z1^-a=3DKlFq=
A
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38D4.bin b/ti/tas2781/TAS2XXX38D4.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca4c0f6dde186d184fdfbbc4d=
ff037e22654262b
> GIT binary patch
> literal 36628
> zcmeHQ3w%_?)j#*{&1Un$B}5G2wFwww0F4md2se?(2C!WM<slRTgm)x71VTV|gEw1>
> zF{r2|&<Yf!*otVChd^`#wgSQ@4{b3@jr#fNR|F{*gpVZq{m<OJVTs{YkXpTy-^t9J
> zIWuSG%$diXdv<R7_U+peEs2SHGyE=3D+29qQaoJ83ja#MzN?vyfWSf5cTsrR%UHTxb;
> zxK<Z|3@CBjOLb(FiDG&J2Gx;v5o*w^sgtHoaNM7pJ?<j>)kY+;SOT=3D{OVY2UW<-uu
> zgfmE{tRl%qRIRq8N?>Y0Mc5UH2ZsZ=3DYE`*F%lVjweFJL6Wtvtb+nG=3D31sWnbg=3DD!C
> zAT~_om3?-SRcbCfEiTz5SCRkD*-OZOy2vk;Yfeeg`YKl0sStcg_E8^sHx1GDDzdgy
> z;e4sGlPt1}9OO^73qCUC6<KVgITfqOgL2_p<Rn@xAE3!7!+|m^+98y=3DQ;|_dN0bpQ
> zyCR-Mxr&yogrKa=3DT$bz%XTCD>Op^~-PRhGOvyjh%e3Gn2JgL_?R7E}_f2(~p{1qD^
> z4;A@ogVj<0f}9i8$wmH%C%t><Wp5O{<UL3my#we)t)3L2?Uf=3DqzjjCp(=3DsL7k|YX6
> zJtZZperr)K%Q-=3DviTYT957FLM9`o*^&E#+0T-4QPqr!A5K>y|yh1kee>9E@fvUSop
> zkv~E8Aa5w@H5T;`rDs%4;H%Zg*e|Z4%p$+iP%Bd!dUwam-UIQLqG}0pq3&qgx#CLc
> zD^3SpBh4o@2%@<iG_C-RB=3D}p=3DepM<bzdT*kO%MN8gncAyd#HJ2SfUMe+Y0$_(RNXD
> z@;7-<r=3D?=3DxA<rhMdR%!2aR+!jPX4BC0=3DT!x??~6nQ+%?jyoJ8_LUt)z1^-a=3DKlFq=
A
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38D5.bin b/ti/tas2781/TAS2XXX38D5.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..3b72b7552531daebcd15b9c70=
fc9ccaa521d1ff4
> GIT binary patch
> literal 63628
> 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
`
> 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
> E|0V-KZU6uP
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38D6.bin b/ti/tas2781/TAS2XXX38D6.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..8cc8cd8a0d23e8bfe5d354aee=
0e81203cc93a5d4
> GIT binary patch
> literal 63628
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38DF.bin b/ti/tas2781/TAS2XXX38DF.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca4c0f6dde186d184fdfbbc4d=
ff037e22654262b
> GIT binary patch
> literal 36628
> zcmeHQ3w%_?)j#*{&1Un$B}5G2wFwww0F4md2se?(2C!WM<slRTgm)x71VTV|gEw1>
> zF{r2|&<Yf!*otVChd^`#wgSQ@4{b3@jr#fNR|F{*gpVZq{m<OJVTs{YkXpTy-^t9J
> zIWuSG%$diXdv<R7_U+peEs2SHGyE=3D+29qQaoJ83ja#MzN?vyfWSf5cTsrR%UHTxb;
> zxK<Z|3@CBjOLb(FiDG&J2Gx;v5o*w^sgtHoaNM7pJ?<j>)kY+;SOT=3D{OVY2UW<-uu
> zgfmE{tRl%qRIRq8N?>Y0Mc5UH2ZsZ=3DYE`*F%lVjweFJL6Wtvtb+nG=3D31sWnbg=3DD!C
> zAT~_om3?-SRcbCfEiTz5SCRkD*-OZOy2vk;Yfeeg`YKl0sStcg_E8^sHx1GDDzdgy
> z;e4sGlPt1}9OO^73qCUC6<KVgITfqOgL2_p<Rn@xAE3!7!+|m^+98y=3DQ;|_dN0bpQ
> zyCR-Mxr&yogrKa=3DT$bz%XTCD>Op^~-PRhGOvyjh%e3Gn2JgL_?R7E}_f2(~p{1qD^
> z4;A@ogVj<0f}9i8$wmH%C%t><Wp5O{<UL3my#we)t)3L2?Uf=3DqzjjCp(=3DsL7k|YX6
> zJtZZperr)K%Q-=3DviTYT957FLM9`o*^&E#+0T-4QPqr!A5K>y|yh1kee>9E@fvUSop
> zkv~E8Aa5w@H5T;`rDs%4;H%Zg*e|Z4%p$+iP%Bd!dUwam-UIQLqG}0pq3&qgx#CLc
> zD^3SpBh4o@2%@<iG_C-RB=3D}p=3DepM<bzdT*kO%MN8gncAyd#HJ2SfUMe+Y0$_(RNXD
> z@;7-<r=3D?=3DxA<rhMdR%!2aR+!jPX4BC0=3DT!x??~6nQ+%?jyoJ8_LUt)z1^-a=3DKlFq=
A
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TAS2XXX38E0.bin b/ti/tas2781/TAS2XXX38E0.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca4c0f6dde186d184fdfbbc4d=
ff037e22654262b
> GIT binary patch
> literal 36628
> zcmeHQ3w%_?)j#*{&1Un$B}5G2wFwww0F4md2se?(2C!WM<slRTgm)x71VTV|gEw1>
> zF{r2|&<Yf!*otVChd^`#wgSQ@4{b3@jr#fNR|F{*gpVZq{m<OJVTs{YkXpTy-^t9J
> zIWuSG%$diXdv<R7_U+peEs2SHGyE=3D+29qQaoJ83ja#MzN?vyfWSf5cTsrR%UHTxb;
> zxK<Z|3@CBjOLb(FiDG&J2Gx;v5o*w^sgtHoaNM7pJ?<j>)kY+;SOT=3D{OVY2UW<-uu
> zgfmE{tRl%qRIRq8N?>Y0Mc5UH2ZsZ=3DYE`*F%lVjweFJL6Wtvtb+nG=3D31sWnbg=3DD!C
> zAT~_om3?-SRcbCfEiTz5SCRkD*-OZOy2vk;Yfeeg`YKl0sStcg_E8^sHx1GDDzdgy
> z;e4sGlPt1}9OO^73qCUC6<KVgITfqOgL2_p<Rn@xAE3!7!+|m^+98y=3DQ;|_dN0bpQ
> zyCR-Mxr&yogrKa=3DT$bz%XTCD>Op^~-PRhGOvyjh%e3Gn2JgL_?R7E}_f2(~p{1qD^
> z4;A@ogVj<0f}9i8$wmH%C%t><Wp5O{<UL3my#we)t)3L2?Uf=3DqzjjCp(=3DsL7k|YX6
> zJtZZperr)K%Q-=3DviTYT957FLM9`o*^&E#+0T-4QPqr!A5K>y|yh1kee>9E@fvUSop
> zkv~E8Aa5w@H5T;`rDs%4;H%Zg*e|Z4%p$+iP%Bd!dUwam-UIQLqG}0pq3&qgx#CLc
> zD^3SpBh4o@2%@<iG_C-RB=3D}p=3DepM<bzdT*kO%MN8gncAyd#HJ2SfUMe+Y0$_(RNXD
> z@;7-<r=3D?=3DxA<rhMdR%!2aR+!jPX4BC0=3DT!x??~6nQ+%?jyoJ8_LUt)z1^-a=3DKlFq=
A
> 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
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TIAS2781RCA2.bin b/ti/tas2781/TIAS2781RCA2.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..b483d69adeb5257cda206de31=
c7146b87835042f
> GIT binary patch
> literal 1004
> zcmZQzV1AQq{3?Wjfsqx68B;n{UNAB+FfjrNC}0NCbAb2?P(A`CIFjg;;sV{=3D{FGD*
> z{LI40!pIKP&jZAaK*+?v5OWh4%nXdojC?>b4yZUN=3D$V*ssAa;U7UVWVv!u)t-Qt}5
> z5(A(yBm<D!N`bmGfS4KVI*{8~7=3DVUxSpoULbioUBmzV<s1IVfTK#bGfB%6cHPf3*p
> ziN(c0Ysd%8KtJUHwU+=3DfC&W*{6wS=3DQ1!M!mn(qkE9}bW>NDu(}Qx5J&M)4Cs@3Anj
> zfWs0LQ!ES|5)hYw*%}N$ji4Z4Vc_yWh;v0i#6htOlw`mXSHO6!1Zp7GO?uRJ695ls
> BDB=3DJB
>
> literal 0
> HcmV?d00001
>
> diff --git a/ti/tas2781/TIAS2781RCA4.bin b/ti/tas2781/TIAS2781RCA4.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..055f7fde1219511f8e980bbf5=
6fa37ed1eb7af5d
> GIT binary patch
> literal 1324
> zcmd^9u}(rU6g{^sN%Inc35f9ni18)J;K0NPvkQZhyc$i65I{o0B(r~^pTfW|_yPWh
> zrxck=3Do^N=3DQP3~)Z?#=3DDV>FEP1S8w0%Yd|Ut$(9=3D<fDsOap#b&CTz1(1yJ^_HO|Nh=
6
> zpBAYbKTc-u!Oh&u*roI5$)fW&HLN!B!O|5Yfj|S*El}$NcV94Io8*$X0nVs<opYlP
> zY3`tinf)oUU)xqVQCMv+cs0!1HrObvlR?OPJQ)St*RoKwRGG94k9bU}d|v0QER~mv
> z@REF9rR$|5yi7i?()BVCUfFzl@Mr;72B-XfEj54Trp?g7A4hNYxaa@Ddy~F|w^5C8
> W(o=3D=3D|#5}+^Q@GEGJ1g8LrtuFB&pu56
>
> literal 0
> HcmV?d00001
>
> --
> 2.34.1
>

